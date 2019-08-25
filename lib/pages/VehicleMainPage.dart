import 'package:basic_app/AppStateContainer.dart';
import 'package:basic_app/model/Vehicle.dart';
import 'package:basic_app/pages/EditVehiclePage.dart';
import 'package:basic_app/pages/UserProfilePage.dart';
import 'package:basic_app/pages/VehicleListPage.dart';
import 'package:flutter/material.dart';

class VehicleMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Garage"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => UserProfilePage()));
            },
          )
        ],
      ),
      body: VehicleListPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewItem(context),
        child: Icon(Icons.add),
      ),
    );
  }

  _addNewItem(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditVehiclePage(
                vehicle: Vehicle(
                    AppStateContainer.of(context).state.loggedInUser,
                    1950,
                    "",
                    ""))));
  }
}
