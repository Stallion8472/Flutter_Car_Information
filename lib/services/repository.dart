import 'package:basic_app/model/Service.dart';
import 'package:basic_app/model/Vehicle.dart';
import 'package:basic_app/services/firebaseProvider.dart';

class Repository {
  final firebaseProvider = FirebaseProvider();

  Future<List<Vehicle>> getVehicles() => firebaseProvider.vehicles();
  Future<List<Service>> getServices() => firebaseProvider.services();

  updateService(Service service) {
    Map<String, dynamic> map = Map();
    map['date'] = service.date;
    map['odometer'] = service.odometer;
    map['serviceType'] = service.serviceTypeToString(service.serviceType);
    map['location'] = service.location;
    map['notes'] = service.notes;
    map['user'] = service.user;
    map['vehicle'] = service.vehicleReference;
    if (service.reference != null) {
      firebaseProvider.updateService(map, service.reference.documentID);
    } else {
      firebaseProvider.addService(map);
    }
  }

  updateVehicle(Vehicle vehicle, {String documentID}) {
    Map<String, dynamic> map = Map();
    map['year'] = vehicle.year;
    map['make'] = vehicle.make;
    map['model'] = vehicle.model;
    map['owner'] = vehicle.owner;
    if (vehicle.reference != null) {
      firebaseProvider.updateVehicle(map, documentID);
    } else {
      firebaseProvider.addVehicle(map);
    }
  }
}
