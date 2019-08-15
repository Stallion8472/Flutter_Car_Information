import 'package:basic_app/model/Service.dart';
import 'package:basic_app/model/Vehicle.dart';
import 'package:basic_app/services/firebaseProvider.dart';

class Repository {
  final firebaseProvider = FirebaseProvider();

  Future<List<Vehicle>> getVehicles() => firebaseProvider.vehicles();
  Future<List<Service>> getServices() => firebaseProvider.services();

  updateService(Service service, {String documentID}) {
    firebaseProvider.updateService(service, documentID: documentID);
  }

  updateVehicle(Vehicle vehicle, {String documentID}) {
    firebaseProvider.updateVehicle(vehicle, documentID: documentID);
  }
}