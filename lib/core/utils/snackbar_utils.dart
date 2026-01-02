import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showError(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      backgroundColor: Theme.of(context).colorScheme.error,
      icon: Icons.error_outline_rounded,
    );
  }

  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      backgroundColor: Colors.green, 
      icon: Icons.check_circle_outline_rounded,
    );
  }

  static void showInfo(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      backgroundColor: Theme.of(context).primaryColor,
      icon: Icons.info_outline_rounded,
    );
  }

  static void showWarning(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      backgroundColor: Colors.orange, 
      icon: Icons.warning_amber_rounded,
    );
  }

  static void _showSnackBar(
    BuildContext context,
    String message, {
    required Color backgroundColor,
    required IconData icon,
  }) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: isTablet ? 30 : 24),
            SizedBox(width: isTablet ? 16 : 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: isTablet ? 18 : 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: 'OpenSans Regular',
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(isTablet ? 24 : 16),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
