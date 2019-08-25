import 'package:basic_app/AppStateContainer.dart';
import 'package:basic_app/model/Service.dart';
import 'package:basic_app/services/servicesBloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditServicePage extends StatefulWidget{

  final Service service;
  final ServicesBloc _servicesBloc;

  EditServicePage(this.service, this._servicesBloc, {Key key}) : super(key: key);

  @override
  _EditServicePageState createState() => _EditServicePageState();
}

class _EditServicePageState extends State<EditServicePage> {

  final odometerController = TextEditingController();
  final notesController = TextEditingController();
  final serviceTypeController = ServiceTypeController();
  final locationController = TextEditingController();
  Timestamp dateController = Timestamp.now();
  DateFormat usFormat = DateFormat('MM-dd-yyyy');

  @override void initState() {
    odometerController.text = widget.service.odometer.toString();
    notesController.text = widget.service.notes;
    serviceTypeController.value = widget.service.serviceType;
    locationController.text = widget.service.location;
    super.initState();
  }
  @override void dispose() {
    odometerController.dispose();
    notesController.dispose();
    serviceTypeController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Details"),
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
                    controller: odometerController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Odometer'
                    ),
                  ),
                  Container(
                    child: Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Row(
                      children: <Widget>[
                        Text('Date: ',
                          style: TextStyle(fontWeight: FontWeight.bold),),
                        GestureDetector(
                          onTap: showDate,
                          behavior: HitTestBehavior.translucent,
                          child: Text(usFormat.format(dateController.toDate())),
                        )
                      ],
                    ),),
                  ),
                  Container(
                    child: Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Row(
                      children: <Widget>[
                        Text('Service Type: ',
                          style: TextStyle(fontWeight: FontWeight.bold),),
                        GestureDetector(
                          onTap: showSelection,
                          behavior: HitTestBehavior.translucent,
                          child: Text(serviceTypeController.type),
                        )
                      ],
                    ),),
                  ),
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                        labelText: 'Location'
                    ),
                  ),
                  TextField(
                    controller: notesController,
                    maxLines: 5,
                    decoration: InputDecoration(
                        labelText: 'Notes'
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
    Service newService = Service(dateController, int.parse(odometerController.text), serviceTypeController.value, locationController.text, notesController.text, AppStateContainer.of(context).state.loggedInUser, Firestore.instance.document(AppStateContainer.of(context).state.selectedVehicle), reference: widget.service.reference ?? null);
    widget._servicesBloc.updateService(newService);
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

  void showSelection() {
    List<Widget> serviceTypeWidgets = List<Widget>();
    for(ServiceType s in ServiceType.values) {
      serviceTypeWidgets.add(
          SimpleDialogOption(
            onPressed: () {
              setState(() {
                serviceTypeController.value = s;
              });
                Navigator.of(context).pop(true);
              },
            child: Text(s.toString().split('.').last)));
      if(s != ServiceType.values.last) {
        serviceTypeWidgets.add(Divider(color: Colors.black));
      }
    }

    showDialog(
      context: context,
      builder: (context) =>
          SimpleDialog(
            title: Text("Service Types"),
            children: serviceTypeWidgets
          )
    );
  }

  void showDate() {
    Future<DateTime> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year+2),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );

    selectedDate.then((chosenDate) => setState((){
      dateController = Timestamp(chosenDate.second, chosenDate.second*1000);
    }));
  }
}

class ServiceTypeController extends ValueNotifier<ServiceType>{
  ServiceTypeController({ServiceType value}) : super(value == null ? value = ServiceType.airFilter : value = value);

  String get type => value.toString().split('.').last;
}