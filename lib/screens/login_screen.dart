import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/screens/sign_up_page.dart';
import 'package:hamro_bhagaicha_batch35d/widget/my_text_button.dart';
import 'package:hamro_bhagaicha_batch35d/widget/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController firstController = TextEditingController();
  final TextEditingController secondContorller = TextEditingController();

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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70),

                Center(
                  child: Column(
                    children: [
                      Image.asset("assets/icons/house_icon.png", height: 140),

                      // SizedBox(height: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hamro Bhagaicha 🌿",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 4, 17, 5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 80),

                Text(
                  "Login",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 30),

                MyTextField(
                  controller: firstController,
                  hintText: "Email",
                  errorText: "Please enter a email",
                ),

                SizedBox(height: 17),
                MyTextField(
                  controller: secondContorller,
                  hintText: "Password",
                  errorText: "Please enter a password",
                ),

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => ForgotPasswordScreen(),
                    //       ),
                    //     );
                    //   },
                    // ),
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 1, 11, 125),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: MyTextButton(onPressed: () {}, text: "Login"),
                ),

                SizedBox(height: 9),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 3),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                      child: Text(
                        "Create one.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
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
