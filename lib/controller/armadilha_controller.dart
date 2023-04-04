import 'package:microsistema/models/armadilhas.dart';
import 'package:microsistema/repositories/armadilha_repository.dart';
import 'package:microsistema/repositories/database_repository.dart';

class ArmadilhaController{

  ArmadilhaRepository repository = ArmadilhaRepository();
  List<String> listStatus = ['A', 'B', 'C', 'D', 'K','P','R','X'];
  Map<int,String> mapStatus = {};
  DatabaseRepository databaseRepository = DatabaseRepository();
  Armadilha? armadilhaSelected;
  List<Armadilha> armadilhas = [];
  List<Armadilha> list = [];

  Future getArmadilhas({bool? sincronizado}) async{
    if (sincronizado!) {
      armadilhas = await repository.getArmadilhas();
      databaseRepository.deleteData("delete from 'armadilhas'");
      save(armadilhas);
    }else {
      List<dynamic> lista = [];
      lista = await databaseRepository.selectData("select * from 'armadilhas';");
      lista.forEach((element) {
        armadilhas.add(Armadilha.fromJson(element));
      });

    }
  }

  Future getArmadilhasbyOs(int? os, int? departamento) async{
    List<dynamic> lista = [];
    list = [];
    armadilhas = [];
    lista = await databaseRepository.selectData("select * from 'armadilhas' where os = ${os} and departamento = ${departamento}");
    lista.forEach((element) {
      armadilhas.add(Armadilha.fromJson(element));
    });
    list = armadilhas;
  }

  int contaArmadilha({String? status, int? departamento, int? os}){
      return (armadilhas??[]).where(
              (element) => element.status == status
                  && element.departamento == departamento
                  && element.os == os).length;
  }
  void save(List<Armadilha> armadilhas) {
    armadilhas.forEach((element) async{
      await databaseRepository.insertData("insert into 'armadilhas'(id,nome,departamento,status,os) values (${element.toString()});");
    });
  }
  void filterArmadilhaByDep(int? departamento, int? os){
    list = armadilhas;
    list = [];
    armadilhas.forEach((element) {
      if(element.departamento == departamento && element.os == os){
        list.add(element);
      }
    });
  }

  Future updateArmadilha(Armadilha? armadilha) async{
    list.forEach((element)  {
       repository.updateArmadilha(element);
    });
  }
}