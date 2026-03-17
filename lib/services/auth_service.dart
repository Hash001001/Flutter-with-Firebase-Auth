import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_tut/models/app_user.dart';

class AuthService {
  static final _firebaseAuth = FirebaseAuth.instance;

  static Future<AppUser?> signUp(String email, String password) async {
    try{

      UserCredential _userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      if(_userCredential != null){
        return AppUser(uid: _userCredential.user!.uid, email: _userCredential.user!.email!);
      }

      return null;

    }catch(e){
      return null;
    }

  }
}
