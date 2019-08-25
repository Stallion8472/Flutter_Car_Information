import 'package:basic_app/AppStateContainer.dart';
import 'package:basic_app/services/auth.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          title: Text("User Name",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          pinned: true,
          // Display a placeholder widget to visualize the shrinking size.
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Column(
                children: <Widget>[
                  Text("User Picture",
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.bold)),
                  Text(AppStateContainer.of(context).state.loggedInUser,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          expandedHeight: 200,
        ),
        SliverList(
            delegate: SliverChildListDelegate.fixed(_userBodyWidgets(context))),
      ]),
    );
  }

  List<Widget> _userBodyWidgets(BuildContext context) {
    List<Widget> newList = [
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 8, 0, 0),
        child: Text("User"),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  child: Text('Name'),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text('Email'),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text('Date of Birth'),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text('Default Address'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: Text("Theme"),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  child: Text('Change Theme'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: Text("Admin"),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Colors.grey[200],
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: SizedBox.expand(
                    child: FlatButton(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.highlight_off),
                          Text('Sign Out'),
                        ],
                      ),
                      onPressed: () => _signOut(context),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: SizedBox.expand(
                    child: FlatButton(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.delete_forever),
                          Text('Delete Account'),
                        ],
                      ),
                      onPressed: () => {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ];
    return newList;
  }

  _signOut(context) {
    _confirmSignout(context);
  }

  Future<void> _confirmSignout(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Auth.signOut();
                Navigator.of(context).pop();
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
