import 'package:basic_app/model/Service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ServiceRow extends StatelessWidget {
  final Service service;
  final DateFormat usFormat = DateFormat('MM-dd-yyyy');

  ServiceRow({Key key, @required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(getIcon(service.serviceType)),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('Type: ${service.serviceType.toString().split('.').last}'),
            Text(
                'Date: ${usFormat.format(service.date.toDate())}',),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('Odometer: ${service.odometer.toString()}'),
            Text('Location: ${service.location}'),
          ],
        ),
      ],
    );
  }

  IconData getIcon(ServiceType serviceType){
    switch(serviceType){
      case ServiceType.airFilter: 
        return Icons.ac_unit;
        break;
      case ServiceType.oil:
        return FontAwesomeIcons.oilCan;
        break;
      case ServiceType.tires:
        return FontAwesomeIcons.tired;
        break;
      case ServiceType.a:
        // TODO: Handle this case.
        break;
      case ServiceType.b:
        // TODO: Handle this case.
        break;
      case ServiceType.c:
        // TODO: Handle this case.
        break;
      case ServiceType.d:
        // TODO: Handle this case.
        break;
      case ServiceType.e:
        // TODO: Handle this case.
        break;
      case ServiceType.f:
        // TODO: Handle this case.
        break;
      case ServiceType.g:
        // TODO: Handle this case.
        break;
    }
  }
}
