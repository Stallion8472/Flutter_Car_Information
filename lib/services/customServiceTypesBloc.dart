import 'package:Car_Maintenance/model/Service.dart';
import 'package:Car_Maintenance/services/firebaseRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class CustomServiceTypesBloc{
  Repository _repository = Repository();

  BehaviorSubject<List<String>> _customserviceTypes;

  CustomServiceTypesBloc(){
    _customserviceTypes = new BehaviorSubject();
  }

  Observable<List<String>> get servicesObservable => _customserviceTypes.stream;

  getServices() async {
    List<DocumentSnapshot> documents = await _repository.get('serviceTypes');
    List<String> services = List();
    for (ServiceType s in ServiceType.values) {
      services.add(Service.serviceTypeToString(s));
    }
    for (var document in documents) {
      services.add(document.data['type']);
    }
    _customserviceTypes.sink.add(services);
  }

  addService(String serviceType, String user) {
    Map<String, dynamic> map = Map();
    map['type'] = serviceType;
    map['user'] = user;
    _repository.update('serviceTypes', map, null);
  }

  deleteService(DocumentReference service){
    _repository.delete('serviceTypes', service.documentID);
  }

  dispose() {
    _customserviceTypes.close();
  }
}