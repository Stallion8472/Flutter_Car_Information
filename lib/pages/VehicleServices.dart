import 'package:basic_app/AppStateContainer.dart';
import 'package:basic_app/components/ServiceRow.dart';
import 'package:basic_app/model/Service.dart';
import 'package:basic_app/pages/EditServicePage.dart';
import 'package:basic_app/services/auth.dart';
import 'package:basic_app/services/servicesBloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VehicleServices extends StatelessWidget {
  final ServicesBloc _servicesBloc = ServicesBloc();

  @override
  build(BuildContext context) {
    _servicesBloc.getServcies();
    return StreamBuilder(
        stream: _servicesBloc.servicesObservable,
        builder: (context, AsyncSnapshot<List<Service>> snapshot) {
          if (snapshot.hasData) {
            List<Service> data = List();
            for (var service in snapshot.data) {
              if (service.vehicleReference ==
                  AppStateContainer.of(context).state.selectedVehicle) {
                data.add(service);
              }
            }
            if (data.length == 0) {
              return Center(
                  child: Text(
                "No service have been added for the selected vehicle",
                style: TextStyle(fontSize: 35),
                textAlign: TextAlign.center,
              ));
            } else {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: EdgeInsets.all(10.0),
                        child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: ServiceRow(service: data[index]),
                            onTap: () =>
                                _editService(context, service: data[index])));
                  });
            }
          }
          return LinearProgressIndicator();
        });
  }

  _editService(BuildContext context, {Service service}) async {
    final Service result = (service != null)
        ? await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditServicePage(service: service)))
        : await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditServicePage(
                    service: Service(
                        Timestamp.now(),
                        0,
                        ServiceType.airFilter,
                        '',
                        '',
                        Auth.userEmail,
                        AppStateContainer.of(context).state.selectedVehicle))));

    if (result != null) {
      if (service != null) {
        _servicesBloc.updateService(result,
            documentID: result.reference.documentID);
      } else {
        _servicesBloc.updateService(result);
      }
    }
  }
}
