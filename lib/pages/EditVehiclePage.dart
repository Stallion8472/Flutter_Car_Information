import 'package:basic_app/AppStateContainer.dart';
import 'package:basic_app/model/Vehicle.dart';
import 'package:basic_app/services/vehicleInformationBloc.dart';
import 'package:flutter/material.dart';

class EditVehiclePage extends StatefulWidget{

  final Vehicle vehicle;

  EditVehiclePage({Key key, @required this.vehicle}) : super(key: key);

  @override
  _EditVehiclePageState createState() => _EditVehiclePageState();
}

class _EditVehiclePageState extends State<EditVehiclePage> {

  final yearController = TextEditingController();
  final makeController = TextEditingController();
  final modelController = TextEditingController();

  final _vehicleInformationBloc = VehicleInformationBloc();

  @override void initState() {
    yearController.text = widget.vehicle.year.toString();
    makeController.text = widget.vehicle.make;
    modelController.text = widget.vehicle.model;
    super.initState();
  }
  @override void dispose() {
    yearController.dispose();
    makeController.dispose();
    modelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.widget.vehicle.year.toString() + " " + this.widget.vehicle.make + " " + this.widget.vehicle.model),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _saveAndClose(context);
              },
              icon: Icon(Icons.save),
            )
          ],
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: yearController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Year'
                    ),
                  ),
                  TextField(
                    controller: makeController,
                    decoration: InputDecoration(
                        labelText: 'Make'
                    ),
                  ),
                  TextField(
                    controller: modelController,
                    decoration: InputDecoration(
                        labelText: 'Model'
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveAndClose(BuildContext context){
    Vehicle newVehicle = Vehicle(AppStateContainer.of(context).state.loggedInUser, int.parse(yearController.text), makeController.text, modelController.text, reference: widget.vehicle.reference);
    if (newVehicle.reference != null) {
        _vehicleInformationBloc.updateVehicle(newVehicle,
            documentID: newVehicle.reference.documentID);
      } else {
        _vehicleInformationBloc.updateVehicle(newVehicle);
      }
    Navigator.of(context).pop();
  }

  Future<bool> _onWillPop() {
      return showDialog(
        context: context,
        builder: (context) =>
          AlertDialog(
            title: Text('Discard your changes?'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          )
      ) ?? false;
    }

}
