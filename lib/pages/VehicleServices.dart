import 'package:Car_Maintenance/AppStateContainer.dart';
import 'package:Car_Maintenance/components/ServiceRow.dart';
import 'package:Car_Maintenance/helperFunctions.dart';
import 'package:Car_Maintenance/model/Service.dart';
import 'package:Car_Maintenance/model/Vehicle.dart';
import 'package:Car_Maintenance/pages/EditServicePage.dart';
import 'package:Car_Maintenance/services/servicesBloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum SortStyle { Odometer, ServiceType }

class VehicleServices extends StatefulWidget {
  final Vehicle _vehicle;

  VehicleServices(this._vehicle);

  @override
  _VehicleServicesState createState() => _VehicleServicesState();
}

class _VehicleServicesState extends State<VehicleServices> {
  ServicesBloc _servicesBloc = ServicesBloc();
  final Set services = Set<String>();
  SortStyle sortingMethod = SortStyle.Odometer;

  @override
  void initState() {
    for (var service in ServiceType.values) {
      services.add(HelperFunctions.enumToString(service.toString()));
    }
    super.initState();
  }

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
              snapshot.data.retainWhere((service) =>
                  service.vehicleReference.path ==
                  AppStateContainer.of(context).state.selectedVehicle);
              return _buildBody(snapshot.data, context);
            } else {
              return LinearProgressIndicator();
            }
          }),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () => _showFilterServicePopup()),
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

  Widget _buildBody(List<Service> snapshot, BuildContext context) {
    snapshot.sort((service1, service2) => _sortServices(service1, service2));
    if (snapshot.length > 0) {
      return ListView.builder(
          itemCount: snapshot.length,
          itemBuilder: (BuildContext context, int index) {
            services
                .add(HelperFunctions.enumToString(snapshot[index].serviceType.toString()));
            return GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: ServiceRow(service: snapshot[index]),
                onTap: () => _editService(context, service: snapshot[index]));
          });
    } else {
      return Center(
        child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              'No service have been added for the your ${widget._vehicle.make} ${widget._vehicle.model}.  Add one now!',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            )),
      );
    }
  }

  _editService(BuildContext context, {Service service}) async {
    var returnedService = (service != null)
        ? await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditServicePage(
                      customServices: services,
                      service: service,
                    )))
        : await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditServicePage(
                      customServices: services,
                    )));
    if (returnedService is Service) {
      _servicesBloc.updateService(returnedService);
    } else if (returnedService is DocumentReference) {
      _servicesBloc.deleteService(returnedService);
    }
  }

  _sortServices(Service service1, Service service2) {
    if (sortingMethod == SortStyle.Odometer) {
      return service1.odometer.compareTo(service2.odometer);
    } else if (sortingMethod == SortStyle.ServiceType) {
      return HelperFunctions.enumToString(service1.serviceType.toString())
          .compareTo(HelperFunctions.enumToString(service2.serviceType.toString()));
    }
  }

  _showFilterServicePopup() {
    List<Widget> sortOptions = List<Widget>();
    for (var sortStyle in SortStyle.values) {
      sortOptions.add(SimpleDialogOption(
        child: Text(HelperFunctions.enumToString(sortStyle.toString())),
        onPressed: () {
          setState(() {
            sortingMethod = sortStyle;
          });
          Navigator.of(context).pop();
        },
      ));
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("Change Sort Method"),
            content: SingleChildScrollView(
                child: ListBody(children: sortOptions))));
  }
}
