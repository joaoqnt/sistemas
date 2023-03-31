import 'package:microsistema/models/departamentos.dart';
import 'package:microsistema/repositories/departamento_repository.dart';

class DepartamentoController{

  DepartamentoRepository repository = DepartamentoRepository();
  Map<int,String> mapStatus = {};
  Departamento? departamentoSelected ;
  List<Departamento> departamentos = [] ;


  Future getDepartamentos(int? os) async{
    departamentos = await repository.getHttp(os);
  }

  void save(Departamento departamento){
    if(departamento.nome!.isNotEmpty)
      repository.save(departamento);
  }

}