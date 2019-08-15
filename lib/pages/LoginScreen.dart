import 'package:basic_app/services/auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);

  final userNameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Car App")
        ),
      body: Center(
        child: Form(
          child: Column(
            children: <Widget>[
              Spacer(flex: 1,),
              Text("Login / Sign Up", style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold)),
              Spacer(flex: 1,),
              Padding(
                child: TextFormField(
                  controller: userNameTextController,
                  decoration: InputDecoration(labelText: "Username"),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
              ),
              Padding(
                child: TextFormField(
                  controller: passwordTextController,
                  decoration: InputDecoration(labelText: "Password"),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
              ),
              Spacer(flex: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Text("Login"),
                    color: Colors.blue[200],
                    onPressed: (){
                      signIn(context);
                      },
                    ),
                  FlatButton(
                    child: Text("Sign Up"),
                    color: Colors.orange[200],
                    onPressed: (){
                      signUp(context);
                    }
                  )
                ],
              ),
              Spacer(flex: 1,),
            ],
          ),
        ),
      ),
    );
  }

  signIn(BuildContext context) async {
    await Auth.signIn(userNameTextController.text, passwordTextController.text);
  }

  signUp(BuildContext context) async {
    await Auth.signUp(userNameTextController.text, passwordTextController.text);
  }
}
