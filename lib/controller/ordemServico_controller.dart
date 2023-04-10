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
}