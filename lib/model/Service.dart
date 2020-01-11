import 'package:cloud_firestore/cloud_firestore.dart';

enum ServiceType{oilChange, airFilter, newTires, balanceAndRotate, transmissionFluid, wiperFluid, newBattery}

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
      case 'Air Filter':
        return ServiceType.airFilter;
        break;
      case 'Oil Change':
        return ServiceType.oilChange;
        break;
      case 'New Tires':
        return ServiceType.newTires;
        break;
      default:
        return ServiceType.airFilter;
    }
  }

  bool operator ==(o) => o is Service && o.date == date && o.location == location && o.notes == notes && o.odometer == odometer && o.serviceType == serviceType && o.user == user;
        int get hashCode => this.hashCode;
}