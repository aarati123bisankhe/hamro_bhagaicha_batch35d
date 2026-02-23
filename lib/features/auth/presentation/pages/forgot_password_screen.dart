import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/api/api_endpoint.dart';
import 'package:hamro_bhagaicha_batch35d/core/utils/snackbar_utils.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/floating_button_action.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/my_text_field.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/login_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _requestResetEmail() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await ref
        .read(authViewModelProvider.notifier)
        .requestPasswordReset(
          email: emailController.text.trim(),
          platform: 'mobile',
          resetUrl: ApiEndpoints.resetPasswordDeepLink,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.status == AuthStatus.passwordResetEmailSent &&
          previous?.status != AuthStatus.passwordResetEmailSent) {
        SnackbarUtils.showSuccess(
          context,
          'Reset email sent. Check your inbox and open the link.',
        );
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
                      SizedBox(height: isTablet ? 130 : 60),
                      Center(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: isTablet ? 40 : 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 90),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Enter your email below. We'll send you",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isTablet ? 23 : 15,
                                color: const Color.fromARGB(255, 4, 17, 5),
                              ),
                            ),
                            Text(
                              'instructions to reset your password.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isTablet ? 23 : 15,
                                color: const Color.fromARGB(255, 4, 17, 5),
                              ),
                            ),
                            const SizedBox(height: 40),
                            MyTextField(
                              controller: emailController,
                              hintText: 'Email',
                              errorText: 'Please enter your email first',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 40),
                            authState.status == AuthStatus.loading
                                ? const CircularProgressIndicator()
                                : MyFloatingButton(
                                    onPressed: _requestResetEmail,
                                    text: 'Reset Password',
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: isTablet ? 25 : 15,
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF000B38),
                                fontSize: isTablet ? 22 : 15,
                              ),
                            ),
                          ),
                        ],
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
