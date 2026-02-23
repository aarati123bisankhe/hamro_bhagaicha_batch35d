import 'dart:io';

class ApiEndpoints {
  ApiEndpoints._();
  static const int port = 5050;

  static String get baseUrl {
    // if (isPhysicalDevice) {
    //   return "http://$computerIpAddress:$port/api";
    // }

    // if (kIsWeb) {
    //   return "http://localhost:$port/api";
    // }

    if (Platform.isAndroid) {
      return "http://10.0.2.2:$port/api";
    }

    if (Platform.isIOS) {
      return "http://localhost:$port/api";
    }

    return "http://localhost:$port/api";
  }

  /// Profile image URL
  static String profileImageUrl(String fileName) {
    if (fileName.startsWith('http')) return fileName;

    // if (isPhysicalDevice) {
    //   return "http://$computerIpAddress:$port/uploads/profile/$fileName";
    // }

    if (Platform.isAndroid) {
      return "http://10.0.2.2:$port/uploads/profile/$fileName";
    }

    return "http://localhost:$port/uploads/profile/$fileName";
  }

  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  static const String authLogin = '/auth/login';
  static const String authRegister = '/auth/register';
  static const String whoAmI = '/auth/whoami';
  static const String requestPasswordReset = '/auth/send-reset-password-email';
  static String resetPassword(String token) => '/auth/reset-password/$token';
  static String getCurrentUserById(String userId) => '/auth/user/$userId';
  static const String notifications = '/notifications';
  static const String markAllNotificationsRead = '/notifications/mark-all-read';
  static String markNotificationRead(String notificationId) =>
      '/notifications/$notificationId/read';

  // Replace with your real domain that hosts .well-known files.
  static const String deepLinkDomain = 'your-domain.com';
  static const String resetPasswordDeepLink =
      'https://$deepLinkDomain/reset-password';

  // Profile picture upload
  static const String updateProfileImage = '/auth/update-profile';
}
