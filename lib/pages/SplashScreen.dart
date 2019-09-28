import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        children: <Widget>[
          Text("MyCarID"),
          Icon(Icons.directions_car)
        ],
      ),
    );
  }
}
