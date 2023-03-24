import 'package:dio/dio.dart';
import 'package:microsistema/models/departamentos.dart';
import 'package:microsistema/repositories/armadilha_repository.dart';

class DepartamentoRepository{

  final dio = Dio();

  void getHttp() async {
    final response = await dio.get('https://dart.dev');
    print(response);
  }

  List<Departamento> departamentos =  [

    Departamento.fromJson(
        {
          "codigo": 1,
          "nome": "Comercial",
          "os":158130
        }
    ),

    Departamento.fromJson(
        {
          "codigo": 2,
          "nome": "Administração",
          "os":158130
        }
    ),

    Departamento.fromJson(
        {
          "codigo": 1,
          "nome": "Administrativo",
          "os":158131
        }
    ),


  ];

  List<Departamento> listAll(){
    return this.departamentos;
  }

  void save(Departamento departamento) {
  }
}