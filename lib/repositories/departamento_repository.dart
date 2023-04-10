import 'package:microsistema/infra/database_infra.dart';
import 'package:microsistema/models/departamentos.dart';
import 'package:microsistema/repositories/armadilha_repository.dart';

class DepartamentoRepository{
  DatabaseInfra database = DatabaseInfra();

  Future<List<Departamento>> getAllDep(int os) async{
    ArmadilhaRepository armadilhaRepository = ArmadilhaRepository();
    List<dynamic> lista = [];
    List<Departamento> listDep = [];
    lista = await database.selectData("select * from 'DEPARTAMENTOS' where os = ${os}");
    lista.forEach((element) async{
      Departamento departamento = Departamento.fromJson(element);
      listDep.add(departamento);
      departamento.armadilhas = await armadilhaRepository.getAllArm(os, departamento.id!);
    });
    return listDep;
  }

  Future<int> saveDepartamento(Map<String,dynamic> departamento, String table) async {
    return await database.insertDataBinding(table, departamento);
  }
}