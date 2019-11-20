import 'package:flutter/material.dart';

class VehicleInformation extends StatefulWidget {
  VehicleInformation({Key key}) : super(key: key);

  @override
  _VehicleInformationState createState() => _VehicleInformationState();
}

class _VehicleInformationState extends State<VehicleInformation> {
  final oilTypeController = TextEditingController();
  final oilFilterController = TextEditingController();

  @override
  void initState(){
    super.initState();
    oilTypeController.text = "";
    oilFilterController.text = "";
  }

  @override
  void dispose(){
    super.dispose();
    oilTypeController.dispose();
    oilFilterController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: oilTypeController,
            decoration: InputDecoration(labelText: 'Oil Type'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: oilFilterController,
            decoration: InputDecoration(labelText: 'Oil Filter number'),
          ),
        ),
      ],
    );
  }
}
