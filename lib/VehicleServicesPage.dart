import 'package:basic_app/ServiceDetailPage.dart';
import 'package:basic_app/ServiceRow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'model/Service.dart';

class VehicleHistory extends StatelessWidget {
  VehicleHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle History"),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _newService(context),
        tooltip: 'New Service',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('service').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildServiceList(context, snapshot.data.documents);
        });
  }

  Widget _buildServiceList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => _buildService(context, data)).toList(),
    );
  }

  Widget _buildService(BuildContext context, DocumentSnapshot data) {
    final service = Service.fromSnapshot(data);
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: ServiceRow(service: service),
            onTap: () => _editService(context, service)));
  }

  _newService(BuildContext context) async {
    final Service result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ServiceDetailPage(
                service: Service(
                    DateTime.now(), 0, ServiceType.airFilter, '', ''))));
    if (result != null) {
      Map<String, dynamic> map = Map();
      map['date'] = result.date.toUtc();
      map['odometer'] = result.odometer;
      map['serviceType'] = result.serviceTypeToString(result.serviceType);
      map['location'] = result.location;
      map['notes'] = result.notes;
      Firestore.instance.collection('service').add(map);
    }
  }

  _editService(BuildContext context, Service service) async {
    final Service result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ServiceDetailPage(service: service)));
    if (result != null) {
      Map<String, dynamic> map = Map();
      map['date'] = result.date.toUtc();
      map['odometer'] = result.odometer;
      map['serviceType'] = result.serviceTypeToString(result.serviceType);
      map['location'] = result.location;
      map['notes'] = result.notes;
      Firestore.instance
          .collection('service')
          .document(result.reference.documentID)
          .setData(map);
    }
  }
}
