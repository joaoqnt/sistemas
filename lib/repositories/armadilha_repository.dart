import 'package:microsistema/infra/database_infra.dart';
import 'package:microsistema/models/armadilhas.dart';

class ArmadilhaRepository{
  DatabaseInfra database = DatabaseInfra();

  Future<List<Armadilha>> getAllArm(int os, int departamento) async{
    List<dynamic> lista = [];
    List<Armadilha> listArmadilhas = [];
    lista = await database.selectData("select * from 'armadilhas' where os = ${os} and departamento = ${departamento}");
    lista.forEach((element) {
      listArmadilhas.add(Armadilha.fromJson(element));
    });
    return listArmadilhas;
  }
}