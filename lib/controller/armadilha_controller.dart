import 'package:microsistema/models/armadilhas.dart';
import 'package:microsistema/repositories/armadilha_repository.dart';

class ArmadilhaController{

  ArmadilhaRepository repository = ArmadilhaRepository();
  List<String> listStatus = ['A', 'B', 'C', 'D', 'K','P','R','X'];
  Map<int,String> mapStatus = {};
  Armadilha? armadilhaSelected;
  List<Armadilha> armadilhas = [];
  List<Armadilha> list = [];

  Future getArmadilhas(int? os) async{
    armadilhas = await repository.getArmadilhas(os);
  }

  int contaArmadilha({String? status, int? departamento, int? os}){
      return (armadilhas??[]).where(
              (element) => element.status == status
                  && element.departamento == departamento
                  && element.os == os).length;
  }

  void filterArmadilhaByDep(int? departamento){
    list = armadilhas;
    list = [];
    armadilhas.forEach((element) {
      if(element.departamento == departamento){
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