import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:microsistema/models/departamentos.dart';

class DepartamentoRepository{

  Future<List<Departamento>> getHttp(int? os) async {
    var http = Dio();
    List<Departamento> departamentos = [];
    Response response = await http.get(
        'https://compraonline.app/api/v5/eco_grupoproduto/grupo_produto/departamentos?os=${os}',
        options: Options(headers:{
          'tenant': 'arcuseco_03683003000165'
        })
    );
    if(response.statusCode == 200){
      // final json = jsonEncode(response);
      response.data["resultSelects"]['grupo_produto'].forEach((element){
        departamentos.add(Departamento.fromJson(element));
      });
    }
    return departamentos;
  }



  void save(Departamento departamento) {
  }
}