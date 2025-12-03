import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/screens/forgot_password_screen.dart';
import 'package:hamro_bhagaicha_batch35d/widget/floating_button_action.dart';
// import 'package:hamro_bhagaicha_batch35d/widget/my_text_button.dart';
import 'package:hamro_bhagaicha_batch35d/widget/my_text_field.dart';

class PersonalDetailScreen extends StatefulWidget {
  const PersonalDetailScreen({super.key});

  @override
  State<PersonalDetailScreen> createState() => _PersonalDetailScreenState();
}

class _PersonalDetailScreenState extends State<PersonalDetailScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController editController = TextEditingController();
  final TextEditingController changedpasswordController =
      TextEditingController();

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
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60),

                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Image.asset(
                        "assets/icons/arrow icon.png",
                        height: 28,
                        width: 28,
                      ),
                    ),
                    SizedBox(width: 60),
                    Text(
                      "Personal Details",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 80),

                MyTextField(
                  controller: fullnameController,
                  hintText: "Full Name",
                  errorText: "Please enter a full name",
                ),

                SizedBox(height: 20),

                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  errorText: "Please enter an email",
                ),

                SizedBox(height: 20),

                MyFloatingButton(onPressed: () {}, text: "Edit"),
                SizedBox(height: 20),
                MyFloatingButton(
                  onPressed: () {},
                  text: "Change Password",
                  color: const Color.fromARGB(255, 188, 199, 183),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
