import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kfc_app/controller/auth_controller.dart';
import 'package:kfc_app/view/home/home_page.dart';
import 'package:kfc_app/view/home/main_screen.dart';
import 'package:kfc_app/view/more/more_page.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600; // Simple responsiveness check

    return GestureDetector(
      onTap: () =>
          FocusScope.of(context).unfocus(), // Dismiss keyboard on tap outside
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // To remove the back button
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "Sign In / Sign up",
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18,
                color: Colors.black87,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // KFC Logo
                SizedBox(height: screenHeight * 0.02),
                Center(
                  child: Image.asset(
                    'assets/app_icon.png', // Replace with your actual logo path
                    height: screenHeight * 0.08,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Main Heading
                Text(
                  "LET'S SIGN IN OR CREATE ACCOUNT WITH\nYOUR PHONE NUMBER!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 18 : 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),

                // Phone Number Input
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Phone Number*",
                    hintText: "Enter 10-digit number",
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Agreement Text
                Text(
                  "By “logging in to KFC”, you agree to our Privacy Policy and Terms & Conditions.",
                  style: TextStyle(
                    fontSize: isSmallScreen ? 12 : 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),

                // Send Me a Code Button
                ElevatedButton(
                  onPressed: () {
                    String phone = phoneController.text.trim();
                    if (phone.isNotEmpty && phone.length == 10) {
                      authController.sendOTP("+91$phone");
                    } else {
                      Get.snackbar("Error",
                          "Please enter a valid 10-digit phone number");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Send Me a Code",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),

                // OR Separator
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[300])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "or",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[300])),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),

                // Skip, Continue As Guest Button
                OutlinedButton(
                  onPressed: () {
                    // Add your logic for continuing as a guest
                    Get.to(() => MorePage()); // Navigate to home screen
                    log("Continue as Guest pressed");
                    // You might navigate to the home screen or a guest order page
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.black87),
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Skip, Continue As Guest",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
