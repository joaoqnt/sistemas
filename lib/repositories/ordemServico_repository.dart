import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';
import 'package:microsistema/infra/database_infra.dart';
import 'package:microsistema/models/ordemServico.dart';
import 'package:microsistema/repositories/armadilha_repository.dart';
import 'package:microsistema/repositories/departamento_repository.dart';
import 'package:microsistema/repositories/produto_repository.dart';

class OrdemServicoRepository {
  DatabaseInfra database = DatabaseInfra();

  Future<bool> getAllOsApi() async {
    var http = Dio();
    try{
      DepartamentoRepository departamentoRepository = DepartamentoRepository();
      ArmadilhaRepository armadilhaRepository = ArmadilhaRepository();
      ProdutoRepository produtoRepository = ProdutoRepository();
      Response response = await http.get(
          'http://mundolivre.dyndns.info:8083/api/v5/et2erp/querys/os',
          options: Options(headers: {'tenant': 'integrador_41806514000116'}));
      if (response.statusCode == 200) {
        cleanTable('ordem_servico');
        cleanTable('departamentos');
        cleanTable('armadilhas');
        cleanTable('produtos');
        cleanTable('produtos_departamento');
        var results = response.data['resultSelects'];
        results['produtos'].forEach((element) async {
          produtoRepository.saveProduto(element, 'produtos');
        });
        results['ordem_servicos'].forEach((element) async {
          List dep = results['departamentos'];
          saveOrdem(element, "ordem_servico");
          dep.where((mapElement) => mapElement['OS'] == element['ID']).toList().forEach((dpt) {
            dpt['OS'] = element['ID'];
            departamentoRepository.saveDepartamento(dpt, 'departamentos');
            results['produto_departamento'].where((produto) => produto['OS'] == element['ID']
                && produto['DEPARTAMENTO'] == dpt['ID']).toList().forEach((resultado) async {
              produtoRepository.saveProduto(resultado, 'produtos_departamento');
            });
            List arm = results['armadilhas'];
            arm.where((mapArm) => mapArm['OS'] == element['ID']
                && mapArm['DEPARTAMENTO'] == dpt['ID']).toList().forEach((armadilha) {
              armadilha['OS'] == element['ID'];
              armadilha['DEPARTAMENTO'] == dpt['ID'];
              armadilhaRepository.saveArmadilha(armadilha, "armadilhas");
            });
          });
        });
      }
      return true;
    }catch (e){
      return false;
    }
  }

  Future<List<OrdemServico>> getAllOsBd() async{
    DepartamentoRepository departamentoRepository = DepartamentoRepository();
    List<dynamic> lista = [];
    List<OrdemServico> listOs = [];
    lista = await database.selectData("select * from 'ordem_servico' order by id desc");
    lista.forEach((element) async {
      OrdemServico os = OrdemServico.fromJson(element);
      listOs.add(os);
      os.departamentos = await departamentoRepository.getAllDep(os.id!);
    });
    return listOs;
  }

  Future<void> cleanTable(String table) async{
    database.deleteData("delete from $table;");
  }

  Future<int> saveOrdem(Map<String,dynamic> ordem, String table) async {
    return await database.insertDataBinding(table, ordem);
  }
  Future<bool> updateOrdem(OrdemServico os) async {
    String armadilhaEncoded = jsonEncode({"1" : [os.toJson()]});
    print(armadilhaEncoded);
    var http = Dio();
    await database.updateData(""
        "update ordem_servico set situacao = 'CONCLUIDO' "
        "where id = ${os.id};");
    os.situacao = 'CONCLUIDO';
    try{
      await http.post(
          'http://mundolivre.dyndns.info:8083/api/v5/json/et2erp/querys/atualiza_situacao',
          options: Options(headers:{
            'tenant': 'integrador_41806514000116',
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: armadilhaEncoded
      );
      return true;
    }catch(e){
      os.pendente = true;
      return false;
    }
  }
}
