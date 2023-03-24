import 'package:microsistema/models/armadilhas.dart';

class ArmadilhaRepository{

  List<Armadilha> armadilhas = [
    Armadilha.fromJson(
        {
          "codigo":1,
          "nome": "Armadilha 1",
          "departamento":1,
          "os":158130
        },
    ),
    Armadilha.fromJson(
      {
        "codigo":2,
        "nome": "Armadilha 2",
        "departamento":1,
        "os":158130
      },
    ),
    Armadilha.fromJson(
      {
        "codigo":1,
        "nome": "Armadilha 1",
        "departamento":2,
        "os":158130
      },
    ),
    Armadilha.fromJson(
      {
        "codigo":2,
        "nome": "Armadilha 2",
        "departamento":2,
        "os":158130
      },
    ),
    Armadilha.fromJson(
      {
        "codigo":3,
        "nome": "Armadilha 3",
        "departamento":2,
        "os":158130
      },
    ),
    Armadilha.fromJson(
      {
        "codigo":4,
        "nome": "Armadilha 4",
        "departamento":2,
        "os":158130
      },
    ),
    Armadilha.fromJson(
      {
        "codigo":1,
        "nome": "Armadilha 1",
        "departamento":1,
        "os":158131
      },
    ),
  ];


  List<Armadilha> listAllByDepartamento(int? departamento){
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
}