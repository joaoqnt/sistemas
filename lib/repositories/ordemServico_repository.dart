import 'package:dio/dio.dart';
import 'package:microsistema/models/ordemServico.dart';

class OrdemServicoRepository{

    Future<List<OrdemServico>> getOs() async {
      var http = Dio();
      List<OrdemServico> ordemservicos = [];
      Response response = await http.get(
          'https://compraonline.app/api/v5/eco_grupoproduto/grupo_produto/os',
          options: Options(headers:{
            'tenant': 'arcuseco_03683003000165'
          })
      );
      if(response.statusCode == 200){
        response.data["resultSelects"]['grupo_produto'].forEach((element){
          ordemservicos.add(OrdemServico.fromJson(element));
        });
      }
      return ordemservicos;
    }


  void save(OrdemServico ordemServico){

  }
}