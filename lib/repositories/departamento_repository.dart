import 'package:microsistema/models/departamentos.dart';
import 'package:microsistema/repositories/armadilha_repository.dart';

class DepartamentoRepository{

  List<Departamento> departamentos =  [

    Departamento.fromJson(
        {
          "codigo": 1,
          "nome": "Comercial",
          "armadilhas":[
            {
              "codigo":1,
              "nome": "Armadilha 1"
            },
            {
              "codigo":2,
              "nome": "Armadilha 2"
            }
          ]
        }
    ),

    Departamento.fromJson(
        {
          "codigo": 2,
          "nome": "Administrativo",
          "armadilhas":[
            {
              "codigo":1,
              "nome": "Armadilha 1"
            },
            {
              "codigo":2,
              "nome": "Armadilha 2"
            },
            {
              "codigo":3,
              "nome": "Armadilha 3"
            }
          ]
        }
    ),


  ];

  List<Departamento> listAll(){
    return this.departamentos;
  }

  void save(Departamento departamento) {
  }
}