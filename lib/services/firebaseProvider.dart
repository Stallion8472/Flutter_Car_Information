import 'package:basic_app/model/Service.dart';
import 'package:basic_app/model/Vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth.dart';

class FirebaseProvider {
  Future<List<Vehicle>> vehicles() async {
    Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
    List<Vehicle> vehicles = List();
    if (Auth.userEmail != "") {
      await Firestore.instance
          .collection('vehicles')
          .where('owner', isEqualTo: Auth.userEmail)
          .getDocuments()
          .then((value) {
        for (var document in value.documents) {
          vehicles.add(Vehicle.fromSnapshot(document));
        }
      });
    } else {
      Auth.signOut();
    }
    return vehicles;
  }

  Future<List<Service>> services() async {
    List<Service> services = List();
    if (Auth.userEmail != "") {
      await Firestore.instance
          .collection('service')
          .where('user', isEqualTo: Auth.userEmail)
          .getDocuments()
          .then((value) {
        for (var document in value.documents) {
          services.add(Service.fromSnapshot(document));
        }
      });
    } else {
      Auth.signOut();
    }
    return services;
  }

  updateService(Map<String, dynamic> map, String documentID) {
    Firestore.instance.collection('service').document(documentID).setData(map);
  }

  addService(Map<String, dynamic> map) {
    Firestore.instance.collection('service').add(map);
  }

  updateVehicle(Map<String, dynamic> map, String documentID) {
    Firestore.instance.collection('vehicles').document(documentID).setData(map);
  }

  addVehicle(Map<String, dynamic> map) {
    Firestore.instance.collection('vehicles').add(map);
  }
}
