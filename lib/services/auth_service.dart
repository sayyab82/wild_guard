import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Sign up with Email and Password
  /// Sends an email verification link
  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;
      await user?.sendEmailVerification();
      return user;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error (SignUp): ${e.message}');
      return null;
    } catch (e) {
      print('Sign Up Error: $e');
      return null;
    }
  }

  /// Login with Email and Password
  /// Only returns user if email is verified
  Future<User?> loginWithEmailPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await result.user?.reload();
      final User? user = _auth.currentUser;

      if (user != null && user.emailVerified) {
        return user;
      } else {
        print("Email not verified");
        return null;
      }
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error (Login): ${e.message}');
      return null;
    } catch (e) {
      print('Login Error: $e');
      return null;
    }
  }

  /// Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error (Google Sign-In): ${e.message}');
      return null;
    } catch (e) {
      print('Google Sign-In Error: $e');
      return null;
    }
  }

  /// Sign out from Firebase and Google
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      print('Sign out error: $e');
    }
  }

  /// Get currently signed-in user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// Check if current user's email is verified
  Future<bool> isEmailVerified() async {
    final user = _auth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  /// Resend email verification link
  Future<void> resendVerificationEmail() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }
}
