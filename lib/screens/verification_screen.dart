import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wild_guard/services/auth_service.dart';

class AccountVerificationScreen extends StatefulWidget {
  const AccountVerificationScreen({super.key});

  @override
  State<AccountVerificationScreen> createState() =>
      _AccountVerificationScreenState();
}

class _AccountVerificationScreenState extends State<AccountVerificationScreen> {
  final authService = AuthService();
  Timer? _verificationTimer;
  bool _isVerified = false;

  @override
  void initState() {
    super.initState();
    _startVerificationCheck();
  }

  void _startVerificationCheck() {
    _verificationTimer = Timer.periodic(Duration(seconds: 3), (timer) async {
      bool verified = await authService.isEmailVerified();
      if (verified) {
        timer.cancel();
        setState(() {
          _isVerified = true;
        });

        // Navigate to login screen
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  void _resendEmail() async {
    await authService.resendVerificationEmail();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Verification email resent! Please check your inbox."),
      ),
    );
  }

  @override
  void dispose() {
    _verificationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/images/Lion.png",
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 140,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Text(
                          "Welcome to",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Wild Guard",
                          style: TextStyle(
                            color: Color(0xFF9A5525),
                            fontSize: 45,
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
                ],
              ),
              Transform.translate(
                offset: Offset(0, -90),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF9A5525),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "    Account Verification",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Image.asset(
                            'assets/icon/paw.png',
                            width: 50,
                            height: 50,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      Text(
                        "A verification email has been sent to your email.\nPlease click the link to verify your email.",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),

                      _isVerified
                          ? Text(
                            "Email verified! Redirecting...",
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 18,
                            ),
                          )
                          : CircularProgressIndicator(color: Colors.white),

                      SizedBox(height: 20),

                      TextButton(
                        onPressed: _resendEmail,
                        child: Text(
                          "Resend Verification Email",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
