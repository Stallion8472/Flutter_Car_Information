import 'package:Car_Maintenance/AppStateContainer.dart';
import 'package:Car_Maintenance/services/auth.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          title: Text("Settings",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Center(
              child: Text(
                  AppStateContainer.of(context).state?.loggedInUser ?? "",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
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
      Card(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              child: SizedBox.expand(
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Name'),
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.black,
              width: MediaQuery.of(context).size.width -
                  MediaQuery.of(context).size.width / 5,
            ),
            Container(
              height: 50,
              child: SizedBox.expand(
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email'),
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.black,
              width: MediaQuery.of(context).size.width -
                  MediaQuery.of(context).size.width / 5,
            ),
            Container(
              height: 50,
              child: SizedBox.expand(
                child: ListTile(
                  leading: Icon(Icons.backup),
                  title: Text('Date of Birth'),
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.black,
              width: MediaQuery.of(context).size.width -
                  MediaQuery.of(context).size.width / 5,
            ),
            Container(
              height: 50,
              child: SizedBox.expand(
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Default Address'),
                ),
              ),
            ),
          ],
        ),
      ),
      Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50,
              child: SizedBox.expand(
                child: ListTile(
                  leading: Icon(Icons.theaters),
                  title: Text('Change Theme'),
                  onTap: () => {},
                ),
              ),
            ),
          ],
        ),
      ),
      Card(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              child: SizedBox.expand(
                child: ListTile(
                  leading: Icon(Icons.highlight_off),
                  title: Text('Sign Out'),
                  onTap: () => _signOut(context),
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.black,
              width: MediaQuery.of(context).size.width -
                  MediaQuery.of(context).size.width / 5,
            ),
            Container(
              height: 50,
              child: SizedBox.expand(
                child: ListTile(
                  leading: Icon(Icons.delete_forever),
                  title: Text('Delete Account'),
                ),
              ),
            ),
          ],
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
              onPressed: () async {
                await Auth.signOut(context);
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
