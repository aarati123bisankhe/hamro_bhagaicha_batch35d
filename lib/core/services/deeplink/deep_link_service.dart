import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deepLinkServiceProvider = Provider<DeepLinkService>((ref) {
  final service = DeepLinkService();
  ref.onDispose(service.dispose);
  return service;
});

class DeepLinkService {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _deepLinkSub;

  Future<void> startListening(void Function(Uri uri) onUri) async {
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      onUri(initialLink);
    }

    _deepLinkSub ??= _appLinks.uriLinkStream.listen(onUri);
  }

  String? getResetToken(Uri uri) {
    final directToken = _extractTokenFromUri(uri);
    if (directToken != null && directToken.isNotEmpty) {
      return directToken;
    }

    final fragment = uri.fragment.trim();
    if (fragment.isEmpty) {
      return null;
    }

    final fragmentUri = Uri.tryParse(fragment);
    if (fragmentUri != null) {
      final fragmentToken = _extractTokenFromUri(fragmentUri);
      if (fragmentToken != null && fragmentToken.isNotEmpty) {
        return fragmentToken;
      }
    }

    try {
      final fragmentQuery = Uri.splitQueryString(fragment);
      final queryStyleToken =
          fragmentQuery['token'] ??
          fragmentQuery['resetToken'] ??
          fragmentQuery['reset_token'];
      if (queryStyleToken != null && queryStyleToken.isNotEmpty) {
        return queryStyleToken;
      }
    } on FormatException {
      // Fragment is not query-string style; ignore and continue.
    }

    return null;
  }

  String? _extractTokenFromUri(Uri uri) {
    final queryToken =
        uri.queryParameters['token'] ??
        uri.queryParameters['resetToken'] ??
        uri.queryParameters['reset_token'];
    if (queryToken != null && queryToken.isNotEmpty) {
      return queryToken;
    }

    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    final resetIndex = segments.indexOf('reset-password');
    if (resetIndex != -1 && resetIndex + 1 < segments.length) {
      return segments[resetIndex + 1];
    }

    return null;
  }

  Future<void> dispose() async {
    await _deepLinkSub?.cancel();
    _deepLinkSub = null;
  }
}
