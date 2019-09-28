import 'package:Car_Maintenance/AppStateContainer.dart';
import 'package:Car_Maintenance/model/Vehicle.dart';
import 'package:Car_Maintenance/pages/EditVehiclePage.dart';
import 'package:Car_Maintenance/pages/UserProfilePage.dart';
import 'package:Car_Maintenance/pages/VehicleListPage.dart';
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
      backgroundColor: Colors.grey[200],
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
