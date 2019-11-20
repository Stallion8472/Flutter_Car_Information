import 'package:Car_Maintenance/AppStateContainer.dart';
import 'package:Car_Maintenance/model/AppState.dart';
import 'package:Car_Maintenance/model/Vehicle.dart';
import 'package:Car_Maintenance/pages/EditVehiclePage.dart';
import 'package:Car_Maintenance/pages/VehicleInformationPage.dart';
import 'package:Car_Maintenance/pages/VehicleServices.dart';
import 'package:Car_Maintenance/services/vehicleInformationBloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VehicleRow extends StatelessWidget {
  final Vehicle vehicle;
  final DateFormat usFormat = DateFormat('MM-dd-yyyy');
  final _vehicleInformationBloc = VehicleInformationBloc();

  VehicleRow({Key key, @required this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => {
            AppStateContainer.of(context).updateState(AppState(
                AppStateContainer.of(context).state.loggedInUser,
                vehicle.reference.path)),
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        VehicleServices(vehicle)))
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text("Year: ",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          Text(vehicle.year.toString() ?? "YEAR",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w300)),
                        ]),
                        Row(
                          children: <Widget>[
                            Text("Make: ",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            Text(vehicle.make ?? "MAKE ",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w300))
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text("Model: ",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            Text(vehicle.model ?? "MODEL",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w300))
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.info_outline),
                          onPressed: () =>
                              Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleInformationPage(vehicle)))),
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () =>
                              _editVehicle(context, vehicle: vehicle))
                    ],
                  )
                ]),
          ),
        ));
  }

  _editVehicle(BuildContext context, {Vehicle vehicle}) async {
    var returnedVehicle = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditVehiclePage(vehicle: vehicle)));
    if (returnedVehicle is Vehicle) {
      _vehicleInformationBloc.updateVehicle(returnedVehicle);
    } else if (returnedVehicle is DocumentReference) {
      _vehicleInformationBloc.deleteVehicle(returnedVehicle);
    }
  }
}
