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

class _VehicleServicesState extends State<VehicleServices>
    with SingleTickerProviderStateMixin {
  final ServicesBloc _servicesBloc = ServicesBloc();
  int _selectedTab = 0;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var loggedInUser = AppStateContainer.of(context).state.loggedInUser;
    _servicesBloc.getServices(loggedInUser);
  }

  @override
  void dispose() {
    super.dispose();
    _servicesBloc.dispose();
    _tabController.dispose();
  }

  @override
  build(BuildContext context) {
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
                      '${widget._vehicle.year.toString().substring(2)} ${widget._vehicle.make} ${widget._vehicle.model}',
                      style: TextStyle(fontSize: 25),
                    ),
                    backgroundColor: Colors.grey,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                        background: Image.asset(
                            widget._vehicle.getVehicleImage(),
                            fit: BoxFit.contain)),
                    expandedHeight: 200,
                    bottom: TabBar(
                      onTap: (tab) => {
                        setState(() {
                          _tabController.animateTo(tab);
                          _selectedTab = tab;
                        })
                      },
                      labelPadding: EdgeInsets.zero,
                      indicatorColor: widget._vehicle.getVehicleColor(),
                      tabs: <Tab>[
                        Tab(text: 'Services'),
                        Tab(text: 'Information'),
                      ],
                      controller: _tabController,
                    ),
                  ),
                  SliverList(delegate: _buildBody(snapshot, context)),
                ],
              );
            } else {
              return LinearProgressIndicator();
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: widget._vehicle.getVehicleColor(),
        onPressed: () => _editService(context),
        child: Icon(Icons.add),
      ),
    );
  }

  SliverChildDelegate _buildBody(
      AsyncSnapshot<List<Service>> snapshot, BuildContext context) {
    if (_selectedTab == 0) {
      return _serviceListDelegate(snapshot, context);
    } else {
      return _informationListDelegate();
    }
  }

  SliverChildDelegate _serviceListDelegate(
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
      return SliverChildListDelegate.fixed(<Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              "No service have been added for the selected vehicle",
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ))
      ]);
    } else {
      return SliverChildListDelegate.fixed(widgets);
    }
  }

  SliverChildDelegate _informationListDelegate() {
    return SliverChildListDelegate.fixed(<Widget>[
      Text(
        "Oil Type: 10W - 30",
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      ),
      Text(
        "Oil Filter number: 123456",
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      ),
    ]);
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
