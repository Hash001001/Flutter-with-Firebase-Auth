import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_tut/models/app_user.dart';

class AuthService {
  static final _firebaseAuth = FirebaseAuth.instance;

  static Future<AppUser?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        return AppUser(
            uid: userCredential.user!.uid, email: userCredential.user!.email!);
      }

      return null;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('SignUp Error: $e');
      rethrow;
    }
  }

  //logging uer out
  static Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print('Logout Error: $e');
      rethrow;
    }
  }

  //sign in user
  static Future<AppUser?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        return AppUser(
            uid: userCredential.user!.uid, email: userCredential.user!.email!);
      }

      return null;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('SignUp Error: $e');
      rethrow;
    }
  }
}
