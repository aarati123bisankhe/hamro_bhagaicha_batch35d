import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/screens/dashboard_screen.dart';
import 'package:hamro_bhagaicha_batch35d/screens/forgot_password_screen.dart';
import 'package:hamro_bhagaicha_batch35d/screens/sign_up_page.dart';
import 'package:hamro_bhagaicha_batch35d/widget/floating_button_action.dart';
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

  final _loginForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
        return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = constraints.maxWidth >= 600;

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
            // child: Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isTablet ? 130 : 30),

                Center(
                  child: Column(
                    children: [
                      Image.asset("assets/icons/house_icon.png", 
                      height: isTablet ? 240 : 140),

                      // SizedBox(height: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hamro Bhagaicha 🌿",
                            style: TextStyle(
                              fontSize: isTablet ? 48 : 28,
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

                Padding(
                  padding: EdgeInsets.fromLTRB(isTablet ? 20 : 15, 0, 15, 0),
                  child: SizedBox(
                    // color: Colors.grey,
                    width: double.infinity,
                    child: Form(
                      key: _loginForm,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: isTablet ? 40 : 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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

                          Padding(
                            padding: EdgeInsets.fromLTRB
                            (isTablet ? 825 : 246, 0, 0, 0),
                            child: MyTextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen(),
                                  ),
                                );
                              },

                              text: 'Forget Password?',
                              
                              textColor:
                               const Color.fromARGB(255, 1, 23, 88),
                            ),
                          ),

                          SizedBox(height: 20),

                          MyFloatingButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashboardScreen(),
                                ),
                              );
                            },
                            text: "Login",
                            // color: Color(0xFF050925),
                            // borderRadius: 6,
                          ),

                          SizedBox(height: 9),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: isTablet ? 25 : 15,
                                ),
                              ),
                              SizedBox(width: 3),

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignupPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Create one.",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
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
              ],
            ),
          ),
        ),
      ),
    );
    // );
      },
        );
  }
}
