import 'package:Car_Maintenance/model/Service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServiceRow extends StatelessWidget {
  final Service service;
  final DateFormat usFormat = DateFormat('MM-dd-yyyy');

  ServiceRow({Key key, @required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(3.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          leading: Icon(getIcon(service.serviceType)),
          title: Column(
            children: <Widget>[
              Text('${Service.serviceTypeToString(service.serviceType)}'),
              Text('${usFormat.format(service.date.toDate())}'),
            ],
          ),
          trailing: Text('${service.odometer.toString()} miles'),
        ),
      ),
    );
  }

  IconData getIcon(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.oilChange:
        return Icons.ac_unit;
        break;
      case ServiceType.airFilter:
        return Icons.ac_unit;
        break;
      case ServiceType.newTires:
        return Icons.ac_unit;
        break;
      case ServiceType.balanceAndRotate:
        return Icons.ac_unit;
        break;
      case ServiceType.transmissionFluid:
        return Icons.ac_unit;
        break;
      case ServiceType.wiperFluid:
        return Icons.ac_unit;
        break;
      case ServiceType.newBattery:
        return Icons.ac_unit;
        break;
      default:
        return Icons.ac_unit;
        break;
    }
  }
}
