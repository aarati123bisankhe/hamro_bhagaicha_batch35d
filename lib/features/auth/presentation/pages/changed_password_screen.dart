import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/app/routes/app_routes.dart';
import 'package:hamro_bhagaicha_batch35d/core/utils/snackbar_utils.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/floating_button_action.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/my_text_field.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/login_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';

class ChangedPasswordScreen extends ConsumerStatefulWidget {
  final String token;

  const ChangedPasswordScreen({super.key, required this.token});

  @override
  ConsumerState<ChangedPasswordScreen> createState() =>
      _ChangedPasswordScreenState();
}

class _ChangedPasswordScreenState extends ConsumerState<ChangedPasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (newPasswordController.text.trim() !=
        confirmNewPasswordController.text.trim()) {
      SnackbarUtils.showError(context, 'Passwords do not match');
      return;
    }

    await ref
        .read(authViewModelProvider.notifier)
        .resetPassword(
          token: widget.token,
          newPassword: newPasswordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.status == AuthStatus.passwordResetSuccess &&
          previous?.status != AuthStatus.passwordResetSuccess) {
        SnackbarUtils.showSuccess(
          context,
          'Password reset successful. Please login again.',
        );
        AppRoutes.pushAndRemoveUntil(context, const LoginScreen());
      }

      if (next.status == AuthStatus.error && next.errorMessage != null) {
        SnackbarUtils.showError(context, next.errorMessage!);
      }
    });

    final authState = ref.watch(authViewModelProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isTablet = constraints.maxWidth >= 600;
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFD8F3DC), Color(0xFF475E4F)],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: isTablet ? 130 : 80),
                      Center(
                        child: Text(
                          'Reset Password',
                          style: TextStyle(
                            fontSize: isTablet ? 40 : 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: isTablet ? 130 : 70),
                      MyTextField(
                        controller: newPasswordController,
                        hintText: 'New Password',
                        errorText: 'Please enter new password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      MyTextField(
                        controller: confirmNewPasswordController,
                        hintText: 'Confirm New Password',
                        errorText: 'Please confirm your password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 30),
                      authState.status == AuthStatus.loading
                          ? const Center(child: CircularProgressIndicator())
                          : MyFloatingButton(
                              onPressed: _submit,
                              text: 'Update',
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
