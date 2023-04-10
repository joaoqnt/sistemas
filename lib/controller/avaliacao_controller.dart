import 'package:microsistema/models/armadilhas.dart';
import 'package:microsistema/models/departamentos.dart';
import 'package:microsistema/repositories/armadilha_repository.dart';
import 'package:microsistema/repositories/departamento_repository.dart';

class AvaliacaoController{
  Departamento? departamentoSelected;
  DepartamentoRepository departamentoRepository = DepartamentoRepository();
  List<Departamento> departamentos = [];
  Armadilha? armadilhaSelected;
  List<Armadilha> armadilhas = [];
  ArmadilhaRepository armadilhaRepository = ArmadilhaRepository();
  List<String> listStatus = ['A', 'B', 'C', 'D', 'K','P','R','X'];


  Future<List<Departamento>> getAllDep(int os) async{
    departamentos = await departamentoRepository.getAllDep(os);
    return departamentos;
  }

  Future<List<Armadilha>> getAllArm(int os, int departamento) async {
    armadilhas = await armadilhaRepository.getAllArm(os, departamento);
    return armadilhas;
  }

  int contaArmadilha({String? status}){
    return armadilhas.where((element) => element.status == status).length;
  }

  Future<bool> updateArmadilhas(Armadilha armadilha, int os, int departamento) async{
    return await armadilhaRepository.updateArmadilha(armadilha, os, departamento);
  }
}