import 'package:basic_app/components/VehicleRow.dart';
import 'package:basic_app/model/Vehicle.dart';
import 'package:basic_app/services/vehicleInformationBloc.dart';
import 'package:flutter/material.dart';

class VehicleInformationPage extends StatelessWidget {
  final VehicleInformationBloc _vehicleInformationBloc =
      new VehicleInformationBloc();

  @override
  Widget build(BuildContext context) {
    _vehicleInformationBloc.getVehicles();
    return StreamBuilder(
      stream: _vehicleInformationBloc.vehiclesObservable,
      builder: (context, AsyncSnapshot<List<Vehicle>> snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.black,
                height: 1,
              );
            },
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return VehicleRow(vehicle: snapshot.data[index]);
            },
          );
        } else {
          return LinearProgressIndicator();
        }
      },
    );
  }
}
