import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:microsistema/models/armadilhas.dart';

class ArmadilhaRepository{

  Future<List<Armadilha>> getArmadilhas() async {
    var http = Dio();
    List<Armadilha> armadilhas = [];
    Response response = await http.get(
        'https://compraonline.app/api/v5/eco_grupoproduto/grupo_produto/armadilhas',
        options: Options(headers:{
          'tenant': 'arcuseco_03683003000165'
        })
    );
    if(response.statusCode == 200){
      // final json = jsonEncode(response);
      // print(response.data);
      response.data["resultSelects"]['grupo_produto'].forEach((element){
        armadilhas.add(Armadilha.fromJson(element));
      });
    }
    return armadilhas;
  }



  int CountByDepartamento(String? status, Map<int, String>? mapStatus,int? departamento){
    int contador = 0;

    mapStatus?.forEach((key, value) {
      if(value.toString() == status){
        contador++;
      }
    });
    return contador;
  }

  Future updateArmadilha(Armadilha armadilha) async{
    String armadilhaEncoded = jsonEncode({"1" : [armadilha.toJson()]});
    var http = Dio();
    var response;
    try{
      response = await http.post(
          'https://compraonline.app/api/v5/json/eco_grupoproduto/grupo_produto/atualiza_status',
          options: Options(headers:{
            'tenant': 'arcuseco_03683003000165',
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: armadilhaEncoded
      );
    }catch (error){
      print('erro $error');
    }
  }
}