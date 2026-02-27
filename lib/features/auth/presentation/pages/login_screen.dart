import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/app/routes/app_routes.dart';
import 'package:hamro_bhagaicha_batch35d/core/utils/snackbar_utils.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/floating_button_action.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/my_text_button.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/my_text_field.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/sign_up_page.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/dashboard_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _loginForm = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final bool _isLoading = false;
  bool _enableBiometricLogin = false;
  bool _showBiometricButton = false;
  bool _isBiometricSupported = false;
  bool _isBiometricAuthFlow = false;

  @override
  void initState() {
    super.initState();
    _loadBiometricAvailability();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_loginForm.currentState!.validate()) {
      _isBiometricAuthFlow = false;
      await ref
          .read(authViewModelProvider.notifier)
          .login(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
    }
  }

  Future<void> _loadBiometricAvailability() async {
    final viewModel = ref.read(authViewModelProvider.notifier);
    final supported = await viewModel.isBiometricSupportedOnDevice();
    if (!mounted) return;
    setState(() {
      _isBiometricSupported = supported;
      _showBiometricButton = supported;
    });
  }

  Future<void> _handleBiometricLogin() async {
    _isBiometricAuthFlow = true;
    final success = await ref
        .read(authViewModelProvider.notifier)
        .loginWithBiometrics();
    if (!success) {
      _isBiometricAuthFlow = false;
    }
  }

  Future<void> _handleAuthenticated() async {
    if (!_isBiometricAuthFlow) {
      await ref
          .read(authViewModelProvider.notifier)
          .setBiometricLoginEnabled(_enableBiometricLogin);
    }
    if (!mounted) return;
    _isBiometricAuthFlow = false;
    SnackbarUtils.showSuccess(context, 'Login successful');
    AppRoutes.pushReplacement(context, DashboardScreen());
  }

  void _navigateToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.status == AuthStatus.authenticated &&
          previous?.status != AuthStatus.authenticated) {
        _handleAuthenticated();
      }

      if (next.status == AuthStatus.error && next.errorMessage != null) {
        SnackbarUtils.showError(context, next.errorMessage!);
      }
    });

    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 50 : 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isTablet ? 120 : 100),

                /// LOGO + TITLE
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/icons/house_icon.png",
                        height: isTablet ? 220 : 130,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Hamro Bhagaicha 🌿",
                        style: TextStyle(
                          fontSize: isTablet ? 46 : 28,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 4, 17, 5),
                          fontFamily: 'OpenSans Regular',
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: isTablet ? 80 : 50),

                Form(
                  key: _loginForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: isTablet ? 40 : 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans Bold',
                        ),
                      ),

                      SizedBox(height: 30),

                      MyTextField(
                        controller: _emailController,
                        hintText: "Email",
                        errorText: "Please enter an email",
                        keyboardType: TextInputType.emailAddress,
                      ),

                      SizedBox(height: 17),

                      MyTextField(
                        controller: _passwordController,
                        hintText: "Password",
                        errorText: "Please enter a password",
                        obscureText: true,
                      ),
                      CheckboxListTile(
                        value: _enableBiometricLogin,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Use Face Lock next time'),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (value) {
                          setState(() {
                            _enableBiometricLogin = value ?? false;
                          });
                        },
                      ),
                      if (!_isBiometricSupported)
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            'Face Lock is not available on this device.',
                          ),
                        ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: MyTextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          text: 'Forget Password?',
                          textColor: const Color.fromARGB(255, 1, 23, 88),
                        ),
                      ),

                      SizedBox(height: 20),

                      _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Row(
                              children: [
                                Expanded(
                                  child: MyFloatingButton(
                                    text: "Login",
                                    onPressed: _handleLogin,
                                  ),
                                ),
                                if (_showBiometricButton) ...[
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: isTablet ? 72 : 54,
                                    height: isTablet ? 64 : 48,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF1B4332,
                                        ),
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      onPressed: _handleBiometricLogin,
                                      child: Icon(
                                        Icons.face,
                                        color: Colors.white,
                                        size: isTablet ? 30 : 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),

                      SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: isTablet ? 22 : 15,
                              fontFamily: 'OpenSans Regular',
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: _navigateToSignup,
                            child: Text(
                              "Create one.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isTablet ? 22 : 15,
                                fontFamily: 'OpenSans Bold',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
