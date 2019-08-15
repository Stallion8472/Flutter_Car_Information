import 'package:basic_app/model/Vehicle.dart';
import 'package:basic_app/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class VehicleInformationBloc{
  List<Vehicle> vehicles;
  Repository _repository = Repository();

  BehaviorSubject<List<Vehicle>> _vehicles;

  VehicleInformationBloc(){
    _vehicles = new BehaviorSubject();
  }

  Observable<List<Vehicle>> get vehiclesObservable => _vehicles.stream;

  getVehicles() async {
    List<Vehicle> vehicles = await _repository.getVehicles();
    _vehicles.sink.add(vehicles);
  }

  updateVehicle(Vehicle vehicle, {String documentID}) {
    _repository.updateVehicle(vehicle, documentID: documentID);
  }

  int get vehicleCount {
    return vehicles.length;
  }

  dispose() {
    _vehicles.close();
  }
}