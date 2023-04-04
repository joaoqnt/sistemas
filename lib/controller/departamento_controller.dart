import 'package:microsistema/models/departamentos.dart';
import 'package:microsistema/repositories/database_repository.dart';
import 'package:microsistema/repositories/departamento_repository.dart';

class DepartamentoController {
  DepartamentoRepository repository = DepartamentoRepository();
  DatabaseRepository databaseRepository = DatabaseRepository();
  Map<int, String> mapStatus = {};
  Departamento? departamentoSelected;

  List<Departamento> departamentos = [];

  bool sincronizado = false;

  Future getDepartamentos({bool? sincronizado}) async {
    if (sincronizado!) {
      departamentos = await repository.getDepartamentos();
      databaseRepository.deleteData("delete from 'departamentos'");
      save(departamentos);
    } else {
      List<dynamic> lista = [];
      lista = await databaseRepository.selectData("select * from 'departamentos';");
      lista.forEach((element) {
        departamentos.add(Departamento.fromJson(element));
      });
    }
  }

  Future getDepartamentosbyOs(int? os) async {
    List<dynamic> lista = [];
    lista = await databaseRepository.selectData("select * from 'departamentos' where os = ${os}");
    lista.forEach((element) {
      departamentos.add(Departamento.fromJson(element));
    });
  }

  void save(List<Departamento> departamentos) {
    departamentos.forEach((element) async{
      await databaseRepository.insertData("insert into 'departamentos'(id,nome,os) values (${element.toString()});");
    });
    repository.save(departamentos);
  }
}
