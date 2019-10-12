import 'package:Car_Maintenance/AppStateContainer.dart';
import 'package:Car_Maintenance/components/VehicleRow.dart';
import 'package:Car_Maintenance/model/Vehicle.dart';
import 'package:Car_Maintenance/services/vehicleInformationBloc.dart';
import 'package:flutter/material.dart';

class VehicleListPage extends StatefulWidget {
  @override
  _VehicleListPageState createState() => _VehicleListPageState();
}

class _VehicleListPageState extends State<VehicleListPage> {
  final VehicleInformationBloc _vehicleInformationBloc =
      VehicleInformationBloc();

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    var loggedInUser = AppStateContainer.of(context).state?.loggedInUser;
    _vehicleInformationBloc
        .getVehicles(loggedInUser);
  }

  @override
  void dispose() {
    super.dispose();
    _vehicleInformationBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _vehicleInformationBloc.vehiclesObservable,
      builder: (context, AsyncSnapshot<List<Vehicle>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0 &&
                  AppStateContainer.of(context).state.selectedVehicle == "") {
                AppStateContainer.of(context).state.selectedVehicle =
                    snapshot.data[index].reference.path;
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
