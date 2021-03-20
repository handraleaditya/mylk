import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.authStateChanges();
  }

  Future<dynamic> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<dynamic> signInWithOTP(
      BuildContext context, String smsCode, String verId, Function error) {
    try {
      print("signed in");
      final AuthCredential authCreds =
          PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
      return signIn(context, authCreds, error);
    } catch (e) {
      error.call();
      debugPrint(e.toString());
      return null;
    }
  }

  Future<dynamic> signIn(
      BuildContext context, AuthCredential authCreds, Function error) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(authCreds);
    } catch (e) {
      debugPrint('Error');
      error.call();
      debugPrint(e.toString());
      return Future.error('Incorrect OTP Entered');
    }
  }
}
