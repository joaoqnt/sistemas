import 'package:dio/dio.dart';
import 'package:microsistema/models/ordemServico.dart';
import 'package:microsistema/repositories/database_repository.dart';

class OrdemServicoRepository {
  DatabaseRepository databaseRepository = DatabaseRepository();

  Future<List<OrdemServico>> getOs({bool? sincronizado}) async {
    var http = Dio();
    List<OrdemServico> ordemservicos = [];
    List<dynamic> lista = [];
    if (sincronizado == false) {
      lista =
          await databaseRepository.selectData("select * from 'ordem_servico';");
      lista.forEach((element) {
        OrdemServico ordemServico = OrdemServico.fromJson(element);
        ordemservicos.add(ordemServico);
      });
    } else {
      await databaseRepository.deleteData("delete from 'ordem_servico'");
      Response response = await http.get(
          'https://compraonline.app/api/v5/eco_grupoproduto/grupo_produto/os',
          options: Options(headers: {'tenant': 'arcuseco_03683003000165'}));
      if (response.statusCode == 200) {
        response.data["resultSelects"]['grupo_produto'].forEach((element) {
          ordemservicos.add(OrdemServico.fromJson(element));
          databaseRepository.insertData("insert into 'ordem_servico'(ID,ID_CLIENTE,NOME_CLIENTE,DATA,PONTOS_MELHORIAS,REL_MONITOR,OBSERVACOES,COMENTARIOS) values (${ordemservicos})");
        });
      }
    }
    return ordemservicos;
  }

  void save(OrdemServico ordemServico) {}
}
