import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wild_guard/services/auth_service.dart';
import 'package:wild_guard/utils/validation_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  final authService = AuthService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  late AnimationController _welcomeController;
  late AnimationController _buttonController;
  late Animation<double> _welcomeFadeAnimation;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();

    _welcomeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    )..forward();

    _buttonController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _welcomeFadeAnimation = CurvedAnimation(
      parent: _welcomeController,
      curve: Curves.easeIn,
    );

    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _welcomeController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.TOP,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.orangeAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> _handleSignUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showToast("Please fill in all fields");
      return;
    }

    List<String> errors = [];

    if (!ValidationUtils.isValidEmail(email)) {
      errors.add("Invalid email format. Example: name@example.com");
    }

    if (!ValidationUtils.isValidPassword(password)) {
      errors.add(
        "Password must be at least 8 characters, include uppercase, lowercase, number, and special character.",
      );
    }

    if (errors.isNotEmpty) {
      for (var error in errors) {
        _showToast(error);
        await Future.delayed(const Duration(seconds: 1));
      }
      return;
    }

    setState(() => _isLoading = true);
    final user = await authService.signUpWithEmailPassword(email, password);
    setState(() => _isLoading = false);

    if (user != null) {
      Navigator.pushNamed(context, '/verification');
    } else {
      _showToast("Sign-up failed. Try again.");
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black54),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF9A5525), // Matching Wild Guard theme
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: screenHeight,
            width: double.infinity,
            child: Image.asset(
              "assets/images/Lion.png",
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.3),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFF9A5525),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          FadeTransition(
                            opacity: _welcomeFadeAnimation,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Sign Up",
                                  key: Key("signup_heading"),
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Image.asset(
                                  'assets/icon/paw.png',
                                  width: 40,
                                  height: 40,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          TextField(
                            key: const Key("name_field"),
                            controller: _nameController,
                            decoration: _inputDecoration("Enter Name"),
                          ),
                          const SizedBox(height: 15),

                          TextField(
                            key: const Key("email_field"),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: _inputDecoration("Enter Email"),
                          ),
                          const SizedBox(height: 15),

                          TextField(
                            key: const Key("password_field"),
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              hintText: "Enter Password",
                              hintStyle: const TextStyle(color: Colors.black54),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black54,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),

                          ScaleTransition(
                            scale: _buttonScaleAnimation,
                            child: SizedBox(
                              width: screenWidth,
                              child: ElevatedButton(
                                key: const Key("signup_button"),
                                onPressed: _isLoading ? null : _handleSignUp,
                                style: _buttonStyle(),
                                child:
                                    _isLoading
                                        ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                        : const Text(
                                          "Next",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          TextButton(
                            key: const Key("login_redirect"),
                            onPressed:
                                () => Navigator.pushNamed(context, '/login'),
                            child: const Text(
                              "Already have an account? Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.15,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _welcomeFadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Welcome to",
                    key: Key("welcome_text"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Wild Guard",
                    key: Key("wild_guard_text"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF9A5525),
                      fontSize: 50,
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
    );
  }
}
