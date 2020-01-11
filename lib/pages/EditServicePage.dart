import 'package:Car_Maintenance/AppStateContainer.dart';
import 'package:Car_Maintenance/helperFunctions.dart';
import 'package:Car_Maintenance/model/Service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditServicePage extends StatefulWidget {
  final Service service;
  final Set<String> customServices;

  EditServicePage({@required this.customServices, this.service, Key key})
      : super(key: key);

  @override
  _EditServicePageState createState() => _EditServicePageState();
}

class _EditServicePageState extends State<EditServicePage> {
  final odometerController = TextEditingController();
  final notesController = TextEditingController();
  String serviceTypeController;
  final locationController = TextEditingController();
  Timestamp dateController;
  DateFormat usFormat = DateFormat('MM-dd-yyyy');

  final customServiceController = TextEditingController();

  @override
  void initState() {
    odometerController.text = widget.service?.odometer?.toString() ?? "0";
    notesController.text = widget.service?.notes ?? "";
    if (widget.service?.serviceType != null) {
      serviceTypeController =
          HelperFunctions.enumToString(widget.service.serviceType.toString());
    } else {
      serviceTypeController = "Air Filter";
    }
    locationController.text = widget.service?.location ?? "";
    if (widget.service?.date != null) {
      dateController = Timestamp.fromDate(widget.service.date.toDate());
    } else {
      dateController = Timestamp.now();
    }
    super.initState();
  }

  @override
  void dispose() {
    odometerController.dispose();
    notesController.dispose();
    locationController.dispose();
    customServiceController.dispose();
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
                _deleteService();
              },
              icon: Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {
                _saveAndClose();
              },
              icon: Icon(Icons.save),
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: odometerController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Odometer'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: showDate,
                behavior: HitTestBehavior.translucent,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Date: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          usFormat.format(dateController.toDate()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () => showServicesDialog(context),
                  behavior: HitTestBehavior.translucent,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(4)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Service Type: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            serviceTypeController,
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: notesController,
                maxLines: 5,
                decoration: InputDecoration(labelText: 'Notes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Service createService() {
    return Service(
        dateController,
        int.parse(odometerController.text),
        Service.stringToServiceType(serviceTypeController),
        locationController.text,
        notesController.text,
        AppStateContainer.of(context).state.loggedInUser,
        Firestore.instance
            .document(AppStateContainer.of(context).state.selectedVehicle),
        reference: widget.service?.reference ?? null);
  }

  void _saveAndClose() {
    var newService = createService();
    Navigator.of(context).pop(newService);
  }

  void _deleteService() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Delete service?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('No'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                    child: Text('Yes'),
                    onPressed: () => {
                          Navigator.of(context).pop(),
                          Navigator.of(context).pop(widget.service?.reference),
                        }),
              ],
            ));
  }

  Future<bool> _onWillPop() {
    var temp = createService();
    if (temp == widget.service) {
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

  void showDate() {
    Future<DateTime> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 2),
    );

    selectedDate.then((chosenDate) => setState(() {
          dateController =
              Timestamp(chosenDate.second, chosenDate.second * 1000);
        }));
  }

  void showServicesDialog(BuildContext customContext) {
    List<Widget> customServiceWidgets = List<Widget>();
    for (var service in widget.customServices) {
      customServiceWidgets.add(SimpleDialogOption(
        child: Text(service),
        onPressed: () {
          setState(() {
            serviceTypeController = service;
          });
          Navigator.of(context).pop();
        },
      ));
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: Text("Service Types"),
                content: SingleChildScrollView(
                    child: ListBody(children: customServiceWidgets)),
                actions: <Widget>[
                  FlatButton(
                      child: Text("New Service"),
                      onPressed: () {
                        setState(() {
                          customServiceController.text = "";
                        });

                        showNewServiceTypePopup(customContext);
                      }),
                  FlatButton(
                      child: Text("Close"),
                      onPressed: () => Navigator.of(context).pop())
                ]));
  }

  void showNewServiceTypePopup(BuildContext customContext) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Enter New Service Type"),
              content: SingleChildScrollView(
                child: TextField(controller: customServiceController),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Add"),
                  onPressed: () {
                    widget.customServices.add(customServiceController.text);  
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
