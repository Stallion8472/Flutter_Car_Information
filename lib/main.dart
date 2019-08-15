import 'package:basic_app/AppStateContainer.dart';
import 'package:basic_app/pages/LoginScreen.dart';
import 'package:basic_app/pages/SplashScreen.dart';
import 'package:basic_app/pages/VehicleMainPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(AppStateContainer(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyCarMD',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: _handleCurrentScreen(),
        //
    );
  }
}

Widget _handleCurrentScreen() {
  return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        } else {
          if (snapshot.hasData) {
            return VehicleMainPage();
          }
          return LoginScreen();
        }
      }
  );
}
