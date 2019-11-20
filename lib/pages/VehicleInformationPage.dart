import 'package:Car_Maintenance/components/VehicleInformation.dart';
import 'package:Car_Maintenance/model/Vehicle.dart';
import 'package:flutter/material.dart';

class VehicleInformationPage extends StatefulWidget {
  final Vehicle _vehicle;

  VehicleInformationPage(this._vehicle);

  @override
  _VehicleInformationPageState createState() => _VehicleInformationPageState();
}

class _VehicleInformationPageState extends State<VehicleInformationPage> {

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget._vehicle.year.toString().substring(2)} ${widget._vehicle.make} ${widget._vehicle.model}'
        ),
      ),
      body: VehicleInformation()
    );
  }
}
