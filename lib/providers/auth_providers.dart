
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_tut/models/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StreamProvider.autoDispose<AppUser?>((ref) async* {

  //create a stream of AppUser that listens to FirebaseAuth's authStateChanges
  //and send continuously updates the AppUser stream whenever the auth state changes
  final Stream<AppUser?> userStream = FirebaseAuth.instance.authStateChanges().map((user){
    if(user != null){
      return AppUser(uid: user.uid, email: user.email!);
    } else {
      return null;
    }
  });

  await for(final user in userStream){
    yield user;
  }

});