import 'package:microsistema/models/ordemServico.dart';

class OrdemServicoRepository{
  List<OrdemServico> ordemservicos =  [

    OrdemServico.fromJson(
        {
          "codigo": 158130,
          "id_cli": 3304,
          "nome_cli": "Via Rural S.A",
          "data": "22/03/2023",
          "pontos_melhorias": "Concentração reduzida",
          "rel_monitor": "Concluido com sucesso",
          "observacoes": "Nada a observar",
          "comentarios": "Nada a comentar"
        }
    ),
    OrdemServico.fromJson(
        {
          "codigo": 158131,
          "id_cli": 3305,
          "nome_cli": "Central Veterinaria S.A",
          "data": "22/03/2023",
          "pontos_melhorias": "Concentração reduzida",
          "rel_monitor": "Concluido com sucesso",
          "observacoes": "Nada a observar",
          "comentarios": "Nada a comentar"
        }
    ),

  ];
  List<OrdemServico> listAll(){
    return this.ordemservicos;
  }

  void save(OrdemServico ordemServico){

  }
}