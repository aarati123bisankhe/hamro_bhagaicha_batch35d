// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/dashboard_screen.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/forgot_password_screen.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/sign_up_page.dart';
// import 'package:hamro_bhagaicha_batch35d/core/widget/floating_button_action.dart';
// import 'package:hamro_bhagaicha_batch35d/core/widget/my_text_button.dart';
// import 'package:hamro_bhagaicha_batch35d/core/widget/my_text_field.dart';
// import 'package:hamro_bhagaicha_batch35d/core/utils/snackbar_utils.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/data/datasource/local/auth_local_datasource.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_hive_model.dart';

// class LoginScreen extends ConsumerStatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   ConsumerState<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends ConsumerState<LoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   final _loginForm = GlobalKey<FormState>();
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final bool isTablet = constraints.maxWidth >= 600;

//         return Scaffold(
//           body: Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Color(0xFFD8F3DC), Color(0xFF475E4F)],
//               ),
//             ),
//             child: SafeArea(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.symmetric(horizontal: isTablet ? 50 : 25),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: isTablet ? 130 : 30),
//                     Center(
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             "assets/icons/house_icon.png",
//                             height: isTablet ? 240 : 140,
//                           ),
//                           Text(
//                             "Hamro Bhagaicha 🌿",
//                             style: TextStyle(
//                               fontSize: isTablet ? 48 : 28,
//                               fontWeight: FontWeight.w600,
//                               color: const Color.fromARGB(255, 4, 17, 5),
//                               fontFamily: 'OpenSans Regular',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 80),
//                     Form(
//                       key: _loginForm,
//                       child: Column(
//                         children: [
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "Login",
//                               style: TextStyle(
//                                 fontSize: isTablet ? 40 : 22,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'OpenSans Bold',
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 30),
//                           MyTextField(
//                             controller: emailController,
//                             hintText: "Email",
//                             errorText: "Please enter an email",
//                             keyboardType: TextInputType.emailAddress,
//                           ),
//                           SizedBox(height: 17),
//                           MyTextField(
//                             controller: passwordController,
//                             hintText: "Password",
//                             errorText: "Please enter a password",
//                             obscureText: true,
//                           ),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: MyTextButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         const ForgotPasswordScreen(),
//                                   ),
//                                 );
//                               },
//                               text: 'Forget Password?',
//                               textColor: const Color.fromARGB(255, 1, 23, 88),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           isLoading
//                               ? const CircularProgressIndicator()
//                               : MyFloatingButton(
//                                   text: "Login",
//                                   onPressed: () async {
//                                     if (!_loginForm.currentState!.validate()) {
//                                       return;
//                                     }

//                                     setState(() => isLoading = true);

//                                     try {
//                                       final authLocal =
//                                           ref.read(authLocalDatasourceProvider);

//                                       // final String email =
//                                       //     emailController.text.trim();
//                                       // final String password =
//                                       //     passwordController.text;

//                                       // final AuthHiveModel? user =
//                                       //     await authLocal.login(email, password);

//                                       final String email = emailController.text.trim().toLowerCase(); // lowercase
//                                       final String password = passwordController.text.trim();          // trim spaces

//                                       final AuthHiveModel? user = await authLocal.login(email, password);




//                                       if (!mounted) return;

//                                       if (user != null) {
//                                         SnackbarUtils.showSuccess(
//                                             context, "Successfully logged in!");
//                                         Navigator.pushReplacement(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 const DashboardScreen(),
//                                           ),
//                                         );
//                                       } else {
//                                         SnackbarUtils.showError(
//                                             context,
//                                             "Invalid email or password");
//                                       }
//                                     } catch (e) {
//                                       SnackbarUtils.showError(
//                                           context, e.toString());
//                                     } finally {
//                                       setState(() => isLoading = false);
//                                     }
//                                   },
//                                 ),
//                           SizedBox(height: 9),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Don't have an account?",
//                                 style: TextStyle(
//                                   fontStyle: FontStyle.italic,
//                                   fontSize: isTablet ? 25 : 15,
//                                   fontFamily: 'OpenSans Regular',
//                                 ),
//                               ),
//                               SizedBox(width: 3),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => const SignupPage(),
//                                     ),
//                                   );
//                                 },
//                                 child: Text(
//                                   "Create one.",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: isTablet ? 22 : 15,
//                                     fontFamily: 'OpenSans Bold',
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }




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
  // final bool _obscurePassword = true;
  final bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_loginForm.currentState!.validate()) {
      await ref
          .read(authViewModelProvider.notifier)
          .login(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
    }
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
        SnackbarUtils.showSuccess(context, 'Login successful');

        if(!mounted) return;
        AppRoutes.pushReplacement(context, DashboardScreen());
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
          colors: [
            Color(0xFFD8F3DC),
            Color(0xFF475E4F),
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 50 : 25,
          ),
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
                        : MyFloatingButton(
                            text: "Login",
                            onPressed: _handleLogin,
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


