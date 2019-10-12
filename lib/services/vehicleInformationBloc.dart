import 'package:Car_Maintenance/model/Vehicle.dart';
import 'package:Car_Maintenance/services/auth.dart';
import 'package:Car_Maintenance/services/firebaseRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class VehicleInformationBloc{
  List<Vehicle> vehicles;
  Repository _repository = Repository();

  PublishSubject<List<Vehicle>> _vehicles;

  VehicleInformationBloc(){
    _vehicles = new PublishSubject();
  }

  Observable<List<Vehicle>> get vehiclesObservable => _vehicles.stream;

  getVehicles(String userEmail) async {
    if(userEmail != null){
      List<DocumentSnapshot> documents = await _repository.get('vehicles', userEmail);
      List<Vehicle> vehicles = List();
      for (var document in documents) {
        vehicles.add(Vehicle.fromSnapshot(document));
      }
      _vehicles.sink.add(vehicles);
    }
    else{
      Auth.signOut();
    }
  }

  updateVehicle(Vehicle vehicle) {
    Map<String, dynamic> map = Map();
    map['year'] = vehicle.year;
    map['make'] = vehicle.make;
    map['model'] = vehicle.model;
    map['owner'] = vehicle.user;
    _repository.update('vehicle', map, vehicle.reference);
  }

  deleteVehicle(DocumentReference vehicle){
    _repository.delete('vehicle', vehicle.documentID);
  }

  dispose() {
    _vehicles.close();
  }
}