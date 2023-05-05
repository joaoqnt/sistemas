import 'package:flutter/material.dart';
import 'package:microsistema/models/armadilhas.dart';
import 'package:microsistema/models/departamentos.dart';
import 'package:microsistema/models/produtos.dart';
import 'package:microsistema/repositories/armadilha_repository.dart';
import 'package:microsistema/repositories/departamento_repository.dart';
import 'package:microsistema/repositories/produto_repository.dart';

class AvaliacaoController{
  Departamento? departamentoSelected;
  DepartamentoRepository departamentoRepository = DepartamentoRepository();
  List<Departamento> departamentos = [];
  // Armadilha? armadilhaSelected;
  List<Armadilha> armadilhas = [];
  List<Armadilha> armadilhasFiltered = [];
  List<Produtos> produtos = [];
  List<Produtos> produtosDepartamento = [];
  Map<String,dynamic> modelo = <String,dynamic>{};
  Produtos? produtoSelected;
  ProdutoRepository produtoRepository = ProdutoRepository();
  ArmadilhaRepository armadilhaRepository = ArmadilhaRepository();
  String statusSelected = "Todos";
  List<String> listStatus = ['A', 'B', 'C', 'D', 'K','P','R','X'];
  List<String> listStatusFilter = ['Todos','A', 'B', 'C', 'D', 'K','P','R','X'];
  TextEditingController tecQuantidade = TextEditingController(text: '1');
  bool valido = false;


  Future<List<Departamento>> getAllDep(int os) async{
    departamentos = await departamentoRepository.getAllDep(os);
    return departamentos;
  }

  bool checkDep(){
    bool valido;
    departamentoSelected == null ? valido = false : valido = true;
    return valido;
  }

  void addProdutoDepartamento(){
    departamentoSelected!.produtos.forEach((element) {
      produtos.where((produto) => produto.id == element.id).forEach((elemento) {
        element.nomeComercial = elemento.nomeComercial;
        element.nomeQuimico = elemento.nomeQuimico;
      });
    });
  }

  onChangeDepartamento(Departamento? value){
    departamentoSelected = value;
    armadilhas = departamentoSelected!.armadilhas;
    produtosDepartamento = departamentoSelected!.produtos;
    filterArmadilhasByStatus(status: "Todos");
    verificaArmadilhasByDep(departamentoSelected!);
    produtosDepartamento = departamentoSelected!.produtos;
  }

  bool verificaProdutoDepartamento(){
    bool retorno = true;
    produtosDepartamento.length >= 15 || produtoSelected == null ||
        departamentoSelected == null || tecQuantidade.text.isEmpty ||
        tecQuantidade.text == '0' ? retorno = false : retorno = true;
    return retorno;
  }

  addList(){
    produtoSelected!.quantidade = double.tryParse(tecQuantidade.text);
    produtoSelected!.pendente = 'S';
    produtosDepartamento.add(produtoSelected!);
    produtos.remove(produtoSelected!);
    produtoSelected = null;
  }

  removeList(int index){
    produtos.add(produtosDepartamento[index]);
    produtosDepartamento.removeAt(index);
    produtos.sort((a,b)=> a.nomeComercial!.compareTo(b.nomeComercial!));
  }

  Future<List<Armadilha>> getAllArm(int os, int departamento) async {
    armadilhas = await armadilhaRepository.getAllArm(os, departamento);
    return armadilhas;
  }

  Future<List<Produtos>> getAllProd() async{
    produtos = await produtoRepository.getAllProd();
    return produtos;
  }

  Future deleteProd(int os, int departamento, int produto) async{
    await produtoRepository.cleanTableByProduto('produtos_departamento', os, departamento, produto);
  }

  Future getAllProdByDep(int os, int dep) async{
    produtosDepartamento = await produtoRepository.getAllProdByDep(os, dep);
  }

  int contaArmadilha({String? status}){
    return armadilhas.where((element) => element.status == status).length;
  }

  Future<bool> updateArmadilhas(Armadilha armadilha, int os, int departamento) async{
    return await armadilhaRepository.updateArmadilha(armadilha, os, departamento);
  }

  Future modelProdDep(int os,int departamento,List<Produtos> listproduto) async{
    int index = 0;
    produtoRepository.cleanTable("produtos_departamento", os, departamento);
    while(index < listproduto.length){
      listproduto.forEach((element) async{
        index++;
        Map<String,dynamic> modelo = {
          'ID':index,
          'OS':os,
          'DEPARTAMENTO':departamento,
          'PRODUTO':element.id,
          'QUANTIDADE':element.quantidade,
          'PENDENTE': element.pendente
        };
        // print(modelo);
        await saveData(modelo, 'produtos_departamento');
        await produtoRepository.insertProdDep(modelo);
      });
    }
  }

  bool verificaArmadilhasByDep(Departamento departamento){
    valido = true;
    departamento.armadilhas.where((element) => element.status == null).forEach((elemento) {
      valido = false;
    });
    return valido;
  }

  filterArmadilhasByStatus({String? status}){
    if(status!.toLowerCase() != "Todos".toLowerCase()){
      statusSelected = status;
      armadilhasFiltered = departamentoSelected!.armadilhas.where((element) => element.status == status).toList();
    }else{
      armadilhasFiltered = departamentoSelected!.armadilhas;
    }
  }

  filter(dynamic value, int index){
    armadilhasFiltered[index].status = value.toString();
    armadilhasFiltered[index].pendente = 'S';
    statusSelected != "Todos"?
    filterArmadilhasByStatus(status: value.toString()) : null;
    verificaArmadilhasByDep(departamentoSelected!);
  }
  Future saveData(produto,table) async{
    await produtoRepository.saveProduto(produto, table);
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