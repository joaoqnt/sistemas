import 'package:microsistema/models/armadilhas.dart';
import 'package:microsistema/repositories/armadilha_repository.dart';

class ArmadilhaController{

  ArmadilhaRepository repository = ArmadilhaRepository();
  List<String> listStatus = ['A', 'B', 'C', 'D', 'K','P','R','X'];
  Map<int,String> mapStatus = {};
  Armadilha? armadilhaSelected;
  List<Armadilha> armadilhas = [];

  List<Armadilha> listAllByDepartamento(int departamento){
    armadilhas = repository.listAllByDepartamento(departamento);
    return armadilhas;
  }

  void filter(int departamento, int os){
    List<Armadilha> list = listAllByDepartamento(departamento);
    armadilhas = [];

    list.forEach((element) {
      if(element.departamento == departamento && element.os == os){
        armadilhas.add(element);
       }
      // print( list.where((element) => element.os == os).length);
    });
  }

  int contaArmadilha({String? status}){
      return (armadilhas??[]).where(
              (element) => element.status == status
                  && element.departamento == armadilhaSelected?.departamento
                  && element.os == armadilhaSelected?.os).length;
  }

}