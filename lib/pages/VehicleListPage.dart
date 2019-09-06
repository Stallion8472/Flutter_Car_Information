import 'package:basic_app/AppStateContainer.dart';
import 'package:basic_app/components/VehicleRow.dart';
import 'package:basic_app/model/Vehicle.dart';
import 'package:basic_app/services/vehicleInformationBloc.dart';
import 'package:flutter/material.dart';

class VehicleListPage extends StatelessWidget {
  final VehicleInformationBloc _vehicleInformationBloc =
      new VehicleInformationBloc();

  @override
  Widget build(BuildContext context) {
    _vehicleInformationBloc.getVehicles();
    return StreamBuilder(
      stream: _vehicleInformationBloc.vehiclesObservable,
      builder: (context, AsyncSnapshot<List<Vehicle>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              if(index == 0 && AppStateContainer.of(context).state.selectedVehicle == ""){
                AppStateContainer.of(context).state.selectedVehicle = snapshot.data[index].reference.path;
              }
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
