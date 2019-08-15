import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle{
  final String owner;
  final int year;
  final String make;
  final String model;
  final DocumentReference reference;

  Vehicle(this.owner, this.year, this.make, this.model, {this.reference});

  Vehicle.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data, reference: snapshot.reference);

  Vehicle.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['owner'] != null),
        assert(map['year'] != null),
        assert(map['make'] != null),
        assert(map['model'] != null),
        owner = map['owner'],
        year = map['year'],
        make = map['make'],
        model = map['model'];
}