import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/screens/login_screen.dart';
import 'package:hamro_bhagaicha_batch35d/widget/floating_button_action.dart';
// import 'package:hamro_bhagaicha_batch35d/widget/my_text_button.dart';
import 'package:hamro_bhagaicha_batch35d/widget/my_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height: 60),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      // child: GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => LoginScreen(),
                      //       ),
                      //     );
                      //   },
                      //   child: Image.asset(
                      //     "assets/icons/arrow icon.png",
                      //     height: 28,
                      //     width: 28,
                      //   ),
                      // ),
                    ),
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 90),

                Center(
                  child: Column(
                    children: [
                      Text(
                        "Enter your email below. We'll send you",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 4, 17, 5),
                        ),
                      ),
                      Text(
                        "instructions to reset your password.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 4, 17, 5),
                        ),
                      ),

                      SizedBox(height: 40),

                      MyTextField(
                        controller: emailController,
                        hintText: "Email",
                        errorText: "Please enter your email first",
                      ),

                      SizedBox(height: 40),

                      MyFloatingButton(
                        onPressed: () {},
                        text: "Reset Password",
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000B38),
                          fontSize: 15,
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
    );
  }
}
