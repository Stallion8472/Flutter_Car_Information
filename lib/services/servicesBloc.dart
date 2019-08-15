import 'package:basic_app/model/Service.dart';
import 'package:basic_app/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class ServicesBloc{
  List<Service> services;
  Repository _repository = Repository();

  BehaviorSubject<List<Service>> _services;

  ServicesBloc(){
    _services = new BehaviorSubject();
  }

  Observable<List<Service>> get servicesObservable => _services.stream;

  getServcies() async {
    List<Service> services = await _repository.getServices();
    _services.sink.add(services);
  }

  updateService(Service service, {String documentID}) {
    _repository.updateService(service, documentID: documentID);
  }

  dispose() {
    _services.close();
  }
}