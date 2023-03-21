import 'package:microsistema/models/armadilhas.dart';
import 'package:microsistema/repositories/armadilha_repository.dart';

class ArmadilhaController{

  ArmadilhaRepository repository = ArmadilhaRepository();
  List<String> listStatus = ['A', 'B', 'C', 'D', 'K','P','R','X'];
  Map<int,String> mapStatus = {};
  Map<int,String> mapStatusCom = {};
  Map<int,String> mapStatusAdm = {};

  List<Armadilha> listAllByDepartamento({int? departamento}){
    return repository.listAllByDepartamento(departamento: departamento);
  }




  // int CountByDepartamento(String? status, Map<int,String>? mapStatus, int? departamento){
  //   if(departamento != null){
  //     return repository.CountByDepartamento(status, mapStatus,departamento);
  //
  //   } else
  //   if(departamento == 1){
  //     mapStatus = mapStatusCom;
  //     // return repository.CountByDepartamento(status, mapStatus, Departamento);
  //   } else {
  //     mapStatus = mapStatusAdm;
  //   }
  //     return 0;
  // }





}