import 'package:Car_Maintenance/AppStateContainer.dart';
import 'package:Car_Maintenance/pages/LoginScreen.dart';
import 'package:Car_Maintenance/pages/SplashScreen.dart';
import 'package:Car_Maintenance/pages/VehicleMainPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(AppStateContainer(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyCarMD',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      home: _handleCurrentScreen(context),
        //
    );
  }
}

Widget _handleCurrentScreen(BuildContext context) {
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
