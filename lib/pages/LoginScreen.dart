import 'package:basic_app/services/auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final passwordConfirmTextController = TextEditingController();

  var isLoginConentVisbile = false;
  var isSignUpContentVisible = false;
  var isLoginButtonVisible = true;
  var isSignUpButtonVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Car App")),
      body: Center(
        child: Form(
          child: Column(
            children: <Widget>[
              Spacer(
                flex: 1,
              ),
              Visibility(
                visible: isLoginButtonVisible,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          child: Text("Login",
                              style: TextStyle(
                                  fontSize: 45, fontWeight: FontWeight.bold)),
                          color: Colors.blue[400],
                          onPressed: () {
                            setState(() {
                              isLoginConentVisbile = !isLoginConentVisbile;
                              isSignUpButtonVisible = !isSignUpButtonVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isLoginConentVisbile,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            child: TextFormField(
                              controller: userNameTextController,
                              decoration:
                                  InputDecoration(labelText: "Username"),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Padding(
                            child: TextFormField(
                              controller: passwordTextController,
                              decoration:
                                  InputDecoration(labelText: "Password"),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          RaisedButton(
                            child: Text("Login"),
                            color: Colors.blue[200],
                            onPressed: () {
                              signIn(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isLoginButtonVisible && isSignUpButtonVisible,
                child: Spacer(
                  flex: 1,
                ),
              ),
              Visibility(
                visible: isSignUpButtonVisible,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          child: Text("Sign Up",
                              style: TextStyle(
                                  fontSize: 45, fontWeight: FontWeight.bold)),
                          color: Colors.orange[400],
                          onPressed: () {
                            setState(() {
                              isSignUpContentVisible = !isSignUpContentVisible;
                              isLoginButtonVisible = !isLoginButtonVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isSignUpContentVisible,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            child: TextFormField(
                              controller: userNameTextController,
                              decoration:
                                  InputDecoration(labelText: "Username"),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Padding(
                            child: TextFormField(
                              controller: passwordTextController,
                              decoration:
                                  InputDecoration(labelText: "Password"),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Padding(
                            child: TextFormField(
                              controller: passwordConfirmTextController,
                              decoration: InputDecoration(
                                  labelText: "Confirm Password"),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          RaisedButton(
                              child: Text("Sign Up"),
                              color: Colors.orange[200],
                              onPressed: () {
                                signUp(context);
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  signIn(BuildContext context) async {
    if (userNameTextController.text != "" &&
        passwordTextController.text != "") {
      await Auth.signIn(
          userNameTextController.text, passwordTextController.text);
    } else {
      //display error
    }
  }

  signUp(BuildContext context) async {
    if (userNameTextController.text != "" &&
        passwordTextController.text != "" &&
        passwordConfirmTextController.text == passwordTextController.text) {
      await Auth.signUp(
          userNameTextController.text, passwordTextController.text);
    }
  }
}
