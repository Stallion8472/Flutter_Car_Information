import 'package:Car_Maintenance/AppStateContainer.dart';
import 'package:Car_Maintenance/components/ServiceRow.dart';
import 'package:Car_Maintenance/model/Service.dart';
import 'package:Car_Maintenance/model/Vehicle.dart';
import 'package:Car_Maintenance/pages/EditServicePage.dart';
import 'package:Car_Maintenance/services/servicesBloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VehicleServices extends StatelessWidget {
  final ServicesBloc _servicesBloc = ServicesBloc();
  final Vehicle _vehicle;

  VehicleServices(this._vehicle);

  @override
  build(BuildContext context) {
    _servicesBloc.getServices(AppStateContainer.of(context).state.loggedInUser);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: StreamBuilder(
          stream: _servicesBloc.servicesObservable,
          builder: (context, AsyncSnapshot<List<Service>> snapshot) {
            if (snapshot.hasData) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    title: Text(
                      '${_vehicle.year.toString().substring(2)} ${_vehicle.make} ${_vehicle.model}',
                      style: TextStyle(fontSize: 25),
                    ),
                    pinned: true,
                    // Display a placeholder widget to visualize the shrinking size.
                    flexibleSpace: Placeholder(),
                    expandedHeight: 200,
                  ),
                  SliverList(delegate: _listDelegate(snapshot, context)),
                ],
              );
            } else {
              return LinearProgressIndicator();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _editService(context),
        child: Icon(Icons.add),
      ),
    );
  }

  SliverChildBuilderDelegate _listDelegate(
      AsyncSnapshot<List<Service>> snapshot, BuildContext context) {
    List<Service> data = List();
    for (var service in snapshot.data) {
      if (service.vehicleReference.path ==
          AppStateContainer.of(context).state.selectedVehicle) {
        data.add(service);
        data.sort((a, b) => a.odometer.compareTo(b.odometer));
      }
    }
    if (data.length == 0) {
      return SliverChildBuilderDelegate(
        (context, index) => Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              "No service have been added for the selected vehicle",
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            )),
        childCount: 1,
      );
    } else {
      return SliverChildBuilderDelegate(
        (context, index) => GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: ServiceRow(service: data[index]),
            onTap: () => _editService(context, service: data[index])),
        childCount: snapshot.data.length,
      );
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
    }
    else if(returnedService is DocumentReference){
      _servicesBloc.deleteService(returnedService);
    }
  }
}
