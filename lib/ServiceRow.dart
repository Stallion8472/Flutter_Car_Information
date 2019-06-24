import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/Service.dart';

class ServiceRow extends StatelessWidget {
  final Service service;
  final DateFormat usFormat = DateFormat('MM-dd-yyyy');

  ServiceRow({Key key, @required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Type: ${service.serviceType.toString().split('.').last}'),
            Text(
                'Date: ${usFormat.format(service.date)}',),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Odometer: ${service.odometer.toString()}'),
            Text('Location: ${service.location}'),
          ],
        ),
      ],
    );
  }
}
