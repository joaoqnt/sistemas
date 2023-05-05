import 'dart:io';

import 'package:dio/dio.dart';
import 'package:microsistema/infra/database_infra.dart';
import 'dart:convert';
import 'package:microsistema/models/produtos.dart';

class ProdutoRepository{
  DatabaseInfra database = DatabaseInfra();
  List<Produtos> _listProd = [];

  Future<List<Produtos>> getAllProdByDep(int os, int dep) async{
    List<dynamic> lista = [];
    List<Produtos> listProd = [];
    lista = await database.selectData("select * from 'PRODUTOS_DEPARTAMENTO' where OS = $os and DEPARTAMENTO = $dep order by id");
    lista.forEach((element) {
      Produtos produtos = Produtos();
      produtos.id = element['PRODUTO'];
      produtos.quantidade = element['QUANTIDADE'];
      listProd.add(produtos);
    });
    return listProd;
  }

  Future<bool> insertProdDep(Map<String,dynamic> modelo) async{
    String produtoDepEncoded = jsonEncode({"1" : [modelo]});
    var http = Dio();
    try{
      await http.post(
          'http://mundolivre.dyndns.info:8083/api/v5/json/et2erp/querys/produto_departamento',
          options: Options(headers:{
            'tenant': 'integrador_41806514000116',
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: produtoDepEncoded
      );
      return true;
    }catch(e){
      return false;
    }
  }

  Future<List<Produtos>> getAllProd() async{
    List<dynamic> lista = [];
    _listProd = [];
    lista = await database.selectData("select * from 'PRODUTOS' order by NOME_COMERCIAL");
    lista.forEach((element) {
      Produtos produtos = Produtos.fromJson(element);
      _listProd.add(produtos);
    });
    return _listProd;
  }

  Future<int> saveProduto(Map<String,dynamic> produto, String table) async {
    return await database.insertDataBinding(table, produto);
  }

  Future<void> cleanTableByProduto(String table,int os, int departamento, int produto) async{
    database.deleteData("delete from $table where OS = $os and DEPARTAMENTO = $departamento and PRODUTO = $produto;");
  }

  Future<void> cleanTable(String table,int os, int departamento) async{
    database.deleteData("delete from $table where OS = $os and DEPARTAMENTO = $departamento;");
  }

}