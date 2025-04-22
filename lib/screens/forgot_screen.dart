import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wild_guard/utils/validation_utils.dart'; // Import the validation utility

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String? _errorMessage; // Store the error message here

  // Function to send password reset email
  void _sendResetEmail() {
    String email = _emailController.text.trim();

    List<String> validationErrors = [];

    // Validate email input using the ValidationUtils class
    if (email.isEmpty) {
      validationErrors.add("Please enter your email.");
    } else if (!ValidationUtils.isValidEmail(email)) {
      validationErrors.add("Invalid email format.");
    }

    // If there are validation errors, update the error message state
    if (validationErrors.isNotEmpty) {
      setState(() {
        _errorMessage = validationErrors.join("\n");
      });
      return;
    }

    // Send the email if validation passes
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((_) {
          setState(() {
            // Update state with success message
            _errorMessage = "Password reset link sent to $email";
          });
        })
        .catchError((e) {
          setState(() {
            // Update state with error message
            _errorMessage = "Failed to send reset email.";
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // TOP IMAGE SECTION
            Stack(
              children: [
                Image.asset(
                  "assets/images/Lion.png",
                  width: double.infinity,
                  height: 460,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome to",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Wild Guard",
                          style: TextStyle(
                            color: Color(0xFF9A5525),
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // RESET EMAIL SECTION
            Transform.translate(
              offset: Offset(0, -70),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: Color(0xFF9A5525),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Forgot Password",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Image.asset(
                            'assets/icon/paw.png',
                            width: 40,
                            height: 40,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // Show error message if present
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),

                    // EMAIL INPUT FIELD
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Enter your Email",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // RESET BUTTON
                    Center(
                      child: ElevatedButton(
                        onPressed: _sendResetEmail,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Send Reset Link",
                          style: TextStyle(
                            color: Color(0xFF9A5525),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    // BACK TO LOGIN BUTTON
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          "Back to Login",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
