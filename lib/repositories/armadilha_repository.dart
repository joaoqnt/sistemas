import 'package:microsistema/models/armadilhas.dart';

class ArmadilhaRepository{

  List<Armadilha> armadilhas = [];


  List<Armadilha> listAllByDepartamento({int? departamento}){
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