import 'package:basic_app/model/Service.dart';
import 'package:basic_app/model/Vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth.dart';

class FirebaseProvider {

  Future<List<Vehicle>> vehicles() async {
    Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
    List<Vehicle> vehicles = List();
    if(Auth.userEmail != ""){
      await Firestore.instance.collection('vehicles').where('owner', isEqualTo: Auth.userEmail).getDocuments().then((value) {
        for (var document in value.documents) {
          vehicles.add(Vehicle.fromSnapshot(document));
        }
      });
    }
    else{
      Auth.signOut();
    }
    return vehicles;
  } 

  Future<List<Service>> services() async {
    List<Service> services = List();
    if(Auth.userEmail != ""){
      await Firestore.instance.collection('service').where('user', isEqualTo: Auth.userEmail).getDocuments().then((value) {
        for(var document in value.documents){
          services.add(Service.fromSnapshot(document));
        }
      });
    }
    else{
      Auth.signOut();
    }
    return services;
  }

  updateService(Service service, {String documentID}){
      Map<String, dynamic> map = Map();
      map['date'] = service.date;
      map['odometer'] = service.odometer;
      map['serviceType'] = service.serviceTypeToString(service.serviceType);
      map['location'] = service.location;
      map['notes'] = service.notes;
      map['user'] = service.user;
    if(documentID.isNotEmpty){
      Firestore.instance.collection('service').document(documentID).setData(map);
    }
    else{
        Firestore.instance.collection('service').add(map);
    }
  }

  updateVehicle(Vehicle vehicle, {String documentID}){
      Map<String, dynamic> map = Map();
      map['year'] = vehicle.year;
      map['make'] = vehicle.make;
      map['model'] = vehicle.model;
      map['owner'] = vehicle.owner;
    if(documentID.isNotEmpty){
      Firestore.instance.collection('vehicles').document(documentID).setData(map);
    }
    else{
        Firestore.instance.collection('vehicles').add(map);
    }
  }
}