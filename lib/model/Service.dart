import 'package:cloud_firestore/cloud_firestore.dart';

enum ServiceType{oil, airFilter, tires,a,b,c,d,e,f,g}

class Service{
  final Timestamp date;
  final int odometer;
  final ServiceType serviceType;
  final String location;
  final String notes;
  final String user;
  final DocumentReference vehicleReference;
  final DocumentReference reference;

  Service(this.date, this.odometer, this.serviceType, this.location, this.notes, this.user, this.vehicleReference, {this.reference});

  Service.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data, reference: snapshot.reference);

  Service.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['odometer'] != null),
        assert(map['date'] != null),
        assert(map['serviceType'] != null),
        assert(map['location'] != null),
        assert(map['notes'] != null),
        assert(map['user'] != null),
        assert(map['vehicle'] != null),
        date = map['date'],
        odometer = map['odometer'],
        serviceType = stringToServiceType(map['serviceType']),
        location = map['location'],
        notes = map['notes'],
        user = map['user'],
        vehicleReference = map['vehicle'];

  static ServiceType stringToServiceType(String type) {
    switch (type) {
      case 'airFilter':
        return ServiceType.airFilter;
      case 'oil':
        return ServiceType.oil;
      case 'tires':
        return ServiceType.tires;
    }
    return ServiceType.airFilter;
  }

  String serviceTypeToString(ServiceType type){
    switch(type){
      case ServiceType.airFilter:
        return 'airFilter';
      case ServiceType.oil:
        return 'oil';
      case ServiceType.tires:
        return 'tires';
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
    return 'airFilter';
  }
}