import 'package:Car_Maintenance/model/Service.dart';
import 'package:Car_Maintenance/services/firebaseRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ServicesBloc{
  List<Service> services;
  Repository _repository = Repository();

  PublishSubject<List<Service>> _services;

  ServicesBloc(){
    _services = new PublishSubject();
  }

  Observable<List<Service>> get servicesObservable => _services.stream;

  getServices(String userEmail) async {
    List<DocumentSnapshot> documents = await _repository.get('service', userEmail);
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
    map['serviceType'] = service.serviceTypeToString(service.serviceType);
    map['location'] = service.location;
    map['notes'] = service.notes;
    map['user'] = service.user;
    map['vehicle'] = service.vehicleReference;
    _repository.update('service', map, service.reference);
  }

  deleteService(DocumentReference service){
    _repository.delete('service', service.documentID);
  }

  dispose() {
    _services.close();
  }
}