import 'package:basic_app/AppStateContainer.dart';
import 'package:basic_app/model/AppState.dart';
import 'package:basic_app/model/Vehicle.dart';
import 'package:basic_app/pages/EditVehiclePage.dart';
import 'package:basic_app/services/auth.dart';
import 'package:basic_app/services/vehicleInformationBloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VehicleRow extends StatelessWidget {
  final Vehicle vehicle;
  final DateFormat usFormat = DateFormat('MM-dd-yyyy');
  final _vehicleInformationBloc = VehicleInformationBloc();

  VehicleRow({Key key, @required this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: _setColor(context),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => AppStateContainer.of(context)
              .updateState(AppState(Auth.user, vehicle.reference)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
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
                IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editVehicle(context, vehicle: vehicle)),
              ]),
        ));
  }

  _editVehicle(BuildContext context, {Vehicle vehicle}) async {
    final Vehicle result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditVehiclePage(vehicle: vehicle)));
    if (result != null) {
      if (vehicle != null) {
        _vehicleInformationBloc.updateVehicle(result,
            documentID: result.reference.documentID);
      } else {
        _vehicleInformationBloc.updateVehicle(result);
      }
    }
  }

  Color _setColor(BuildContext context) {
    if (AppStateContainer.of(context).state.selectedVehicle ==
        vehicle.reference) {
      return Colors.black12;
    } else {
      return Colors.white;
    }
  }
}
