import 'package:microsistema/models/armadilhas.dart';
import 'package:microsistema/models/departamentos.dart';
import 'package:microsistema/repositories/departamento_repository.dart';

class DepartamentoController{

  DepartamentoRepository repository = DepartamentoRepository();
  Map<int,String> mapStatus = {};

  //List<Departamento> departamentos ;


  List<Departamento> listAll(){
    return repository.listAll();
  }

  void save(Departamento departamento){
    if(departamento.nome!.isNotEmpty)
      repository.save(departamento);
  }

  int contaArmadilha({String? status, Departamento? departamento}){
    if(departamento == null)
      return 0;
    else
      return (departamento.armadilhas??[]).where((element) => element.status == status).length;
  }



}