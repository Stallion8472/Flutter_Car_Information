import 'package:Car_Maintenance/AppStateContainer.dart';
import 'package:Car_Maintenance/model/Vehicle.dart';
import 'package:flutter/material.dart';

class EditVehiclePage extends StatefulWidget {
  final Vehicle vehicle;

  EditVehiclePage({Key key, @required this.vehicle}) : super(key: key);

  @override
  _EditVehiclePageState createState() => _EditVehiclePageState();
}

class _EditVehiclePageState extends State<EditVehiclePage> {
  final yearController = TextEditingController();
  final makeController = TextEditingController();
  final modelController = TextEditingController();

  @override
  void initState() {
    yearController.text = widget.vehicle.year.toString();
    makeController.text = widget.vehicle.make;
    modelController.text = widget.vehicle.model;
    super.initState();
  }

  @override
  void dispose() {
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
          title: Text(this.widget.vehicle.year.toString() +
              " " +
              this.widget.vehicle.make +
              " " +
              this.widget.vehicle.model),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _deleteVehicle(context);
              },
              icon: Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {
                _saveAndClose(context);
              },
              icon: Icon(Icons.save),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  TextField(
                    controller: yearController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Year'),
                  ),
                  TextField(
                    controller: makeController,
                    decoration: InputDecoration(labelText: 'Make'),
                  ),
                  TextField(
                    controller: modelController,
                    decoration: InputDecoration(labelText: 'Model'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Comments'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Vehicle createVehicle(){
    return Vehicle(
        AppStateContainer.of(context).state.loggedInUser,
        int.parse(yearController.text),
        makeController.text,
        modelController.text,
        reference: widget.vehicle.reference);
  }

  void _saveAndClose(BuildContext context) {
    var newVehicle = createVehicle();
    Navigator.of(context).pop(newVehicle);
  }

  void _deleteVehicle(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Delete vehicle?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('No'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                    child: Text('Yes'),
                    onPressed: () => {
                          Navigator.of(context).pop(),
                          Navigator.of(context).pop(widget.vehicle?.reference),
                        }),
              ],
            ));
  }

  Future<bool> _onWillPop() {
    if(createVehicle() == widget.vehicle){
      return Future.value(true);
    }
    return showDialog(
            context: context,
            builder: (context) => AlertDialog(
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
                )) ??
        false;
  }
}
