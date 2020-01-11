import 'package:Car_Maintenance/helperFunctions.dart';
import 'package:Car_Maintenance/model/Service.dart';
import 'package:Car_Maintenance/services/firebaseRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ServicesBloc{
  Repository _repository = Repository();

  PublishSubject<List<Service>> _services;

  ServicesBloc(){
    _services = new PublishSubject();
  }

  Observable<List<Service>> get servicesObservable => _services.stream;

  getServices() async {
    List<DocumentSnapshot> documents = await _repository.get('service');
    List<Service> services = List();
    for (var document in documents) {
      services.add(Service.fromSnapshot(document));
    }
    _services.sink.add(services);
  }

  updateService(Service service) {
    Map<String, dynamic> map = Map();
    map['date'] = service.date;
    map['odometer'] = service.odometer;
    map['serviceType'] = HelperFunctions.enumToString(service.serviceType.toString());
    map['location'] = service.location;
    map['notes'] = service.notes;
    map['user'] = service.user;
    map['vehicle'] = service.vehicleReference;
    _repository.update('service', map, service.reference);
    getServices();
  }

  deleteService(DocumentReference service){
    _repository.delete('service', service.documentID);
  }

  dispose() {
    _services.close();
  }
}