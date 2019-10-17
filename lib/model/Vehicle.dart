import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum Makes{ Pontiac, Ford, Hyundai }

class Vehicle{
  String user;
  int year;
  String make;
  String model;
  DocumentReference reference;

  Vehicle(this.user, this.year, this.make, this.model, {this.reference});

  Vehicle.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data, reference: snapshot.reference);

  Vehicle.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['user'] != null),
        assert(map['year'] != null),
        assert(map['make'] != null),
        assert(map['model'] != null),
        user = map['user'],
        year = map['year'],
        make = map['make'],
        model = map['model'];

        bool operator ==(o) => o is Vehicle && o.make == make && o.model == model && o.user == user && o.year == year;
        int get hashCode => this.hashCode;
  
  String getVehicleImage(){
    var imagePath = "lib/assets/images/";
    switch (this.make) {
      case "Pontiac":
        return imagePath + "pontiacImage.png";
        break;
      case "Ford":
        return imagePath + "fordImage.png";
        break;
      default:
        return "";
    }
  }

  Color getVehicleColor(){
    switch (this.make) {
      case "Pontiac":
        return Colors.red;
        break;
      case "Ford":
        return Colors.indigo[600];
        break;
      default:
        return Colors.green;
    }
  }
}