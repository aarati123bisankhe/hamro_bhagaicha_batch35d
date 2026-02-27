import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/app/routes/app_routes.dart';
import 'package:hamro_bhagaicha_batch35d/core/utils/snackbar_utils.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/floating_button_action.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/my_text_field.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/login_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';

class ResetPasswordCodeScreen extends ConsumerStatefulWidget {
  final String email;

  const ResetPasswordCodeScreen({super.key, required this.email});

  @override
  ConsumerState<ResetPasswordCodeScreen> createState() =>
      _ResetPasswordCodeScreenState();
}

class _ResetPasswordCodeScreenState
    extends ConsumerState<ResetPasswordCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    if (newPassword != confirmPassword) {
      SnackbarUtils.showError(context, 'Passwords do not match');
      return;
    }

    await ref
        .read(authViewModelProvider.notifier)
        .resetPasswordWithCode(
          email: widget.email,
          code: _codeController.text.trim(),
          newPassword: newPassword,
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
    final isTablet = MediaQuery.of(context).size.width >= 600;

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
                  SizedBox(height: isTablet ? 120 : 70),
                  Center(
                    child: Text(
                      'Reset With Code',
                      style: TextStyle(
                        fontSize: isTablet ? 40 : 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: isTablet ? 80 : 50),
                  Text(
                    'Code sent to: ${widget.email}',
                    style: TextStyle(fontSize: isTablet ? 20 : 14),
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: _codeController,
                    hintText: '6-digit code',
                    errorText: 'Please enter reset code',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: _newPasswordController,
                    hintText: 'New Password',
                    errorText: 'Please enter new password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm New Password',
                    errorText: 'Please confirm new password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  authState.status == AuthStatus.loading
                      ? const Center(child: CircularProgressIndicator())
                      : MyFloatingButton(
                          onPressed: _submit,
                          text: 'Update Password',
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
