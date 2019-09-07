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

  var isLogin = true;
  var rememberUser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          children: <Widget>[
            Spacer(
              flex: 1,
            ),
            Text(
              "Car App",
              style: TextStyle(fontSize: 58),
            ),
            Spacer(
              flex: 1,
            ),
            _loginWidget(),
            Spacer(
              flex: 1,
            ),
            _changeLoginSignUpStateButton(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 12,
              child: SizedBox.expand(
                child: _loginSignUpButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _changeLoginSignUpStateButton() {
    if (isLogin) {
      return MaterialButton(
          child: Text("New User? Sign Up"),
          onPressed: () => setState(() {
                isLogin = !isLogin;
              }));
    } else {
      return MaterialButton(
          child: Text("Returning User? Log in"),
          onPressed: () => setState(() {
                isLogin = !isLogin;
              }));
    }
  }

  Widget _loginSignUpButton() {
    if (isLogin) {
      return RaisedButton(
          child: Text("Login"),
          color: Colors.blue[200],
          onPressed: () {
            signIn(context);
          });
    } else {
      return RaisedButton(
          child: Text("Sign Up"),
          color: Colors.orange[200],
          onPressed: () {
            signUp(context);
          });
    }
  }

  Widget _loginWidget() {
    if (isLogin) {
      return Column(
        children: <Widget>[
          Column(
            children: <Widget>[
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
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Remember Me"),
                  Checkbox(
                      value: rememberUser,
                      onChanged: (bool newValue) {
                        setState(() {
                          rememberUser = !rememberUser;
                        });
                      }),
                ],
              ),
              FlatButton(
                child: Text("Forgot Password?"),
                onPressed: () => {},
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Column(
            children: <Widget>[
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
              Padding(
                child: TextFormField(
                  controller: passwordConfirmTextController,
                  decoration: InputDecoration(labelText: "Confirm Password"),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ],
          ),
        ],
      );
    }
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
