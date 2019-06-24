import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'LoginScreen.dart';
import 'SplashScreen.dart';
import 'VehicleServicesPage.dart';

void main() => runApp(MyApp());

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
          //return SplashScreen();
          return VehicleHistory();
        } else {
          if (snapshot.hasData) {
            return VehicleHistory();
          }
          return LoginScreen();
        }
      }
  );
}
