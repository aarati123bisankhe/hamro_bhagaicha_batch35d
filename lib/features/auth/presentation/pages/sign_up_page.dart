import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/utils/snackbar_utils.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/my_text_field.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/floating_button_action.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/login_screen.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!formKey.currentState!.validate()) return;

    final authViewModel = ref.read(authViewModelProvider.notifier);

    authViewModel.register(
      fullName: fullNameController.text.trim(),
      email: emailController.text.trim().toLowerCase(),
      password: passwordController.text.trim(),
      address: addressController.text.trim(),
      phoneNumber: phoneController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    final authState = ref.watch(authViewModelProvider);

    ref.listen<AuthState>(authViewModelProvider, (prev, next) {
      if (next.status == AuthStatus.error) {
        SnackbarUtils.showError(
          context,
          next.errorMessage ?? 'Registration failed',
        );
      } else if (next.status == AuthStatus.registered) {
        SnackbarUtils.showSuccess(
          context,
          'Registration successful! Please log in.',
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });

    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
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
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 50 : 25),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/icons/house_icon.png",
                        height: isTablet ? 240 : 140,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Hamro Bhagaicha 🌿",
                        style: TextStyle(
                          fontFamily: 'OpenSans Regular',
                          fontSize: isTablet ? 40 : 23,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 4, 17, 5),
                        ),
                      ),
                      SizedBox(height: isTablet ? 70 : 35),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontFamily: 'OpenSans Bold',
                            fontSize: isTablet ? 29 : 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF000B38),
                          ),
                        ),
                      ),
                      SizedBox(height: isTablet ? 25 : 20),
                      MyTextField(
                        controller: fullNameController,
                        hintText: "Full Name",
                        errorText: "Full Name cannot be empty",
                      ),
                      SizedBox(height: isTablet ? 20 : 15),
                      MyTextField(
                        controller: emailController,
                        hintText: "Email",
                        errorText: "Email cannot be empty",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: isTablet ? 20 : 15),
                      MyTextField(
                        controller: passwordController,
                        hintText: "Password",
                        errorText: "Password cannot be empty",
                        obscureText: true,
                      ),
                      SizedBox(height: isTablet ? 20 : 15),
                      MyTextField(
                        controller: addressController,
                        hintText: "Address",
                        errorText: "Address cannot be empty",
                      ),
                      SizedBox(height: isTablet ? 20 : 15),
                      MyTextField(
                        controller: phoneController,
                        hintText: "Phone Number",
                        errorText: "Phone Number cannot be empty",
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: isTablet ? 30 : 25),
                      isLoading || authState.status == AuthStatus.loading
                          ? const CircularProgressIndicator()
                          : MyFloatingButton(
                              text: "Sign Up",
                              onPressed: _handleSignup,
                            ),
                      SizedBox(height: isTablet ? 15 : 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontFamily: 'OpenSans Regular',
                              fontStyle: FontStyle.italic,
                              fontSize: isTablet ? 25 : 15,
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontFamily: 'OpenSans Bold',
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF000B38),
                                fontSize: isTablet ? 22 : 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isTablet ? 20 : 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
