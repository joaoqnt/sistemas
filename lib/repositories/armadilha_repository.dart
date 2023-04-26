import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';
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

  Future<int> saveArmadilha(Map<String,dynamic> armadilha, String table) async {
    return await database.insertDataBinding(table, armadilha);
  }

  Future<bool> updateArmadilha(Armadilha armadilha, int os, int departamento) async{
    String armadilhaEncoded = jsonEncode({"1" : [armadilha.toJson(os: os,departamento: departamento)]});
    var http = Dio();
    var response;
    await database.updateData(""
        "update armadilhas set status = '${armadilha.status}' "
        "where id = ${armadilha.id} and os = $os and departamento = $departamento;");
    try{
       response = await http.post(
          'http://mundolivre.dyndns.info:8083/api/v5/json/et2erp/querys/atualiza_status',
          options: Options(headers:{
            'tenant': 'integrador_41806514000116',
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: armadilhaEncoded
      );
       armadilha.pendente = 'N';
       return true;
    }catch (error){
      print(armadilha.pendente);
      return false;
    }
  }
}