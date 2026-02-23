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
    if (uri.path == '/reset-password' || uri.path == '/reset-password/') {
      return uri.queryParameters['token'];
    }

    if (uri.pathSegments.length >= 2 &&
        uri.pathSegments.first == 'reset-password') {
      return uri.pathSegments[1];
    }

    return null;
  }

  Future<void> dispose() async {
    await _deepLinkSub?.cancel();
    _deepLinkSub = null;
  }
}
