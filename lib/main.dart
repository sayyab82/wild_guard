import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import '';

// Screens
import 'screens/launcher_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/verification_screen.dart';
import 'screens/forgot_screen.dart';
import 'screens/changedpassword_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBpEdoxPvNSdQB0CxK-e-aoqAdVNrAs_3s",
        authDomain: "wildguard-c36ed.firebaseapp.com",
        projectId: "wildguard-c36ed",
        storageBucket: "wildguard-c36ed.firebasestorage.app",
        messagingSenderId: "1013995385216",
        appId: "1:1013995385216:web:2534e0026998d24f779165",
        measurementId: "G-VRKPWKVPHT",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.brown),
      initialRoute: '/',
      routes: {
        '/': (context) => const LauncherScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/verification': (context) => const AccountVerificationScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/changedpassword': (context) => const ChangedPasswordScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
