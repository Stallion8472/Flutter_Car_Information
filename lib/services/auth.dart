import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static String userEmail = "";

  static Future<String> signIn(String email, String password) async {
    FirebaseUser user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
        userEmail = user.email;
    return user.uid;
  }

  static Future<String> signUp(String email, String password) async {
    FirebaseUser user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
        userEmail = user.email;
    return user.uid;
  }
  static void signOut() {
    FirebaseAuth.instance.signOut();
    userEmail = "";
  }
}