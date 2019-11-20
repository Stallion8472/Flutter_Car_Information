import 'package:Car_Maintenance/AppStateContainer.dart';
import 'package:Car_Maintenance/components/ServiceRow.dart';
import 'package:Car_Maintenance/model/Service.dart';
import 'package:Car_Maintenance/model/Vehicle.dart';
import 'package:Car_Maintenance/pages/EditServicePage.dart';
import 'package:Car_Maintenance/services/servicesBloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VehicleServices extends StatefulWidget {
  final Vehicle _vehicle;

  VehicleServices(this._vehicle);

  @override
  _VehicleServicesState createState() => _VehicleServicesState();
}

class _VehicleServicesState extends State<VehicleServices> {
  final ServicesBloc _servicesBloc = ServicesBloc();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _servicesBloc.getServices();
  }

  @override
  void dispose() {
    super.dispose();
    _servicesBloc.dispose();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget._vehicle.year.toString().substring(2)} ${widget._vehicle.make} ${widget._vehicle.model}'),
      ),
      body: StreamBuilder(
          stream: _servicesBloc.servicesObservable,
          builder: (context, AsyncSnapshot<List<Service>> snapshot) {
            if (snapshot.hasData) {
              return _buildBody(snapshot, context);
            } else {
              return LinearProgressIndicator();
            }
          }),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(icon: Icon(Icons.menu), onPressed: () => {}),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => {},
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _editService(context),
        icon: Icon(Icons.add),
        label: Text("Add Service"),
        elevation: 4,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBody(
      AsyncSnapshot<List<Service>> snapshot, BuildContext context) {
    snapshot.data.sort((a, b) => a.odometer.compareTo(b.odometer));
    List<Widget> widgets = List();
    for (var service in snapshot.data) {
      if (service.vehicleReference.path ==
          AppStateContainer.of(context).state.selectedVehicle) {
        widgets.add(GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: ServiceRow(service: service),
            onTap: () => _editService(context, service: service)));
      }
    }
    if (widgets.length == 0) {
      return Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Text(
            "No service have been added for the selected vehicle",
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ));
    } else {
      return ListView(children: widgets);
    }
  }

  _editService(BuildContext context, {Service service}) async {
    var returnedService = (service != null)
        ? await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditServicePage(
                      service: service,
                    )))
        : await Navigator.push(context,
            MaterialPageRoute(builder: (context) => EditServicePage()));
    if (returnedService is Service) {
      _servicesBloc.updateService(returnedService);
    } else if (returnedService is DocumentReference) {
      _servicesBloc.deleteService(returnedService);
    }
  }
}
