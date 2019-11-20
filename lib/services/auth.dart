import 'package:Car_Maintenance/AppStateContainer.dart';
import 'package:Car_Maintenance/model/AppState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Auth {
  static Future<String> signIn(String email, String password, BuildContext context) async {
    AuthResult authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    if(authResult.user.email.isNotEmpty) {
      AppStateContainer.of(context)
          .updateState(AppState(authResult.user.email, ""));
    }
      return authResult.user.email;
  }

  static Future<String> signUp(String email, String password) async {
    AuthResult authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return authResult.user.email;
  }

  static Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    AppStateContainer.of(context).updateState(AppState("", ""));
  }
}
