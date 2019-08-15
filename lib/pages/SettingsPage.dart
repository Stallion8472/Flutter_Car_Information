import 'package:basic_app/services/auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Spacer(flex: 1,),
          Text("Settings", style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold)),
          Spacer(flex: 2),
          FlatButton(
            child: Text('Change Theme'),
            onPressed: (){

            },
          ),
          FlatButton(
            child: Text('Sign Out'),
            textColor: Colors.red,
            onPressed: (){
              _signOut(context);
            },
          ),
          FlatButton(
            child: Text('Delete Account'),
            color: Colors.red,
            textColor: Colors.white,
            onPressed: (){

            },
          ),
          Spacer(flex: 1,)
        ],
      )
    );
  }

  _signOut(context){
    _confirmLogout(context);
  }

  Future<void>_confirmLogout(BuildContext context) async{
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Auth.signOut();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
