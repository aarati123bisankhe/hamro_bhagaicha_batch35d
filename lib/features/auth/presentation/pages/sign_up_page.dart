import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/login_screen.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/floating_button_action.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/my_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
          child: Center(
            child: SingleChildScrollView(
              padding:  EdgeInsets.symmetric(
                horizontal: 25),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Image.asset("assets/icons/house_icon.png", 
                    height: isTablet ? 240 :  140),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hamro Bhagaicha 🌿",
                          style: TextStyle(
                            fontSize: isTablet ? 40 : 23,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 4, 17, 5),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: isTablet ? 70 : 35),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: isTablet ? 29 :  18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000B38),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    MyTextField(
                      controller: fullNameController,
                      hintText: "Full Name",
                      errorText: "Full Name cannot be empty",
                    ),
                    SizedBox(height: 15),

                    MyTextField(
                      controller: emailController,
                      hintText: "Email",
                      errorText: "Email cannot be empty",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 15),

                    MyTextField(
                      controller: passwordController,
                      hintText: "Password",
                      errorText: "Password cannot be empty",
                      obscureText: true,
                    ),
                    SizedBox(height: 15),

                    MyTextField(
                      controller: addressController,
                      hintText: "Address",
                      errorText: "Address cannot be empty",
                    ),
                    SizedBox(height: 15),

                    MyTextField(
                      controller: phoneController,
                      hintText: "Phone Number",
                      errorText: "Phone Number cannot be empty",
                      keyboardType: TextInputType.phone,
                    ),

                    SizedBox(height: 25),

                    MyFloatingButton(
                      text: "Sign Up",
                      onPressed: () {
                      },
                    ),

                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: isTablet ? 25 : 15,
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
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF000B38),
                              fontSize: isTablet ? 22 : 15,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                  ],
                ),
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
