import 'package:flutter/material.dart';
import 'package:microsistema/models/ordemServico.dart';
import 'package:microsistema/repositories/ordemServico_repository.dart';

class OrdemServicoController{
  OrdemServicoRepository repository = OrdemServicoRepository();
  List<OrdemServico> ordemservicos = [];
  List<OrdemServico> filteredOrdemservicos = [];
  OrdemServico? ordemServicoSellected;
  TextEditingController tecBusca = TextEditingController();
  bool? sincronizado;
  bool? valido;
  bool isOrdered = false;


  Future<bool> getAllOs() async {
    bool ret = await repository.getAllOsApi();
    ordemservicos = await repository.getAllOsBd();
    filteredOrdemservicos = ordemservicos;
    sincronizado = ret;
    return sincronizado!;
  }
  void filterOs(String? busca){
    filteredOrdemservicos = ordemservicos.where((element) =>
    element.id.toString().contains(busca.toString()) ||
        element.nomeCli!.toLowerCase().contains(busca!.toLowerCase())).toList();
  }

  Future getAllBd() async{
    try{
      ordemservicos = await repository.getAllOsBd();
    }catch(e){
      print("Erro ao pegar dados do banco de dados $e");
    }
    filteredOrdemservicos = ordemservicos;
  }

  Future<bool> updateSituacaoOrdem({OrdemServico? os,List<OrdemServico>? listOs}) async{
    if(listOs != null && listOs.isNotEmpty){
      listOs!.where((element) => element.pendente == true).forEach((elemento) async{
        await repository.updateOrdem(elemento);
      });
    }
    if(os != null){
      await repository.updateOrdem(os);
    }
      return true;
  }

  bool verificaStatus(OrdemServico os){
    valido = true;
    os.departamentos!.forEach((element) {
      element.armadilhas!.where((element) => element.status == null).forEach((element) {
        valido = false;
      });
    });
    return valido!;
  }

  void orderBy(){
    if(!isOrdered){
      filteredOrdemservicos.sort((OrdemServico b, OrdemServico a)=> a.data!.compareTo(b.data!));
      isOrdered = true;
    }
    else{
      filteredOrdemservicos.sort((OrdemServico a, OrdemServico b)=> a.data!.compareTo(b.data!));
      isOrdered = false;
    }
  }
}