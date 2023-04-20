import 'package:flutter/material.dart';
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
  List<Armadilha> armadilhasFiltered = [];
  ArmadilhaRepository armadilhaRepository = ArmadilhaRepository();
  String statusSelected = "Todos";
  List<String> listStatus = ['A', 'B', 'C', 'D', 'K','P','R','X'];
  List<String> listStatusFilter = ['Todos','A', 'B', 'C', 'D', 'K','P','R','X'];
  TextEditingController tecPontos = TextEditingController();
  TextEditingController tecRelat = TextEditingController();
  TextEditingController tecObserv = TextEditingController();
  TextEditingController tecComent = TextEditingController();
  bool valido = false;


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

  bool verificaArmadilhasByDep(Departamento departamento){
    valido = true;
    departamento.armadilhas!.where!((element) => element.status == null).forEach((elemento) {
      valido = false;
    });
    return valido!;
  }

  filterArmadilhasByStatus({String? status}){
    if(status!.toLowerCase() != "Todos".toLowerCase()){
      statusSelected = status;
      armadilhasFiltered = departamentoSelected!.armadilhas!.where((element) => element.status == status).toList();
    }else{
      armadilhasFiltered = departamentoSelected!.armadilhas!;
    }
  }


  List<Widget> listWidget(){
    List<Widget> l = [];
    listStatus.forEach((element) {
      l.add(Text('$element:''${contaArmadilha(status: element)}',
          style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold))
      );
    });
    return l;
  }
}