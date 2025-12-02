import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/screens/personal_detail_screen.dart';
import 'package:hamro_bhagaicha_batch35d/widget/my_text_button.dart';
import 'package:hamro_bhagaicha_batch35d/widget/my_text_field.dart';

class ChangedPasswordScreen extends StatefulWidget {
  const ChangedPasswordScreen({super.key});

  @override
  State<ChangedPasswordScreen> createState() => _ChangedPasswordScreenState();
}

class _ChangedPasswordScreenState extends State<ChangedPasswordScreen> {
  final TextEditingController currentpasswordController =
      TextEditingController();
  final TextEditingController newpasswordController = TextEditingController();
  final TextEditingController confirmnewpasswordController =
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
                const SizedBox(height: 80),

                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonalDetailScreen(),
                          ),
                        );
                      },
                      child: Image.asset(
                        "assets/icons/arrow icon.png",
                        height: 28,
                        width: 28,
                      ),
                    ),
                    const SizedBox(width: 50),
                    const Text(
                      "Change Password",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 70),

                MyTextField(
                  controller: currentpasswordController,
                  hintText: "Current Password",
                  errorText: "Please enter current password",
                ),

                const SizedBox(height: 20),

                /// NEW PASSWORD
                MyTextField(
                  controller: newpasswordController,
                  hintText: "New Password",
                  errorText: "Please enter new password",
                ),

                const SizedBox(height: 20),

                /// CONFIRM PASSWORD
                MyTextField(
                  controller: confirmnewpasswordController,
                  hintText: "Confirm New Password",
                  errorText: "Please confirm your password",
                ),

                const SizedBox(height: 30),

                /// UPDATE BUTTON
                MyTextButton(onPressed: () {}, text: "Update"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
