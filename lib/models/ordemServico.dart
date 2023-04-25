import 'package:microsistema/models/departamentos.dart';
import 'package:microsistema/utils/dataformato_util.dart';

class OrdemServico {
  int? id;
  int? idCli;
  String? nomeCli;
  DateTime? data;
  String? pontosMelhorias;
  String? relMonitor;
  String? observacoes;
  String? comentarios;
  List<Departamento>? departamentos = [];
  String? situacao;
  bool pendente = false;

  OrdemServico(
      {this.id,
        this.idCli,
        this.nomeCli,
        this.data,
        this.pontosMelhorias,
        this.relMonitor,
        this.observacoes,
        this.comentarios,
        this.situacao
      });

  OrdemServico.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    idCli = json['ID_CLIENTE'];
    nomeCli = json['NOME_CLIENTE'];
    data = DateTime.parse(json['DATA']);
    pontosMelhorias = json['PONTOS_MELHORIAS'];
    relMonitor = json['REL_MONITOR'];
    observacoes = json['OBSERVACOES'];
    comentarios = json['COMENTARIOS'];
    situacao = json['SITUACAO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['ID_CLIENTE'] = this.idCli;
    data['NOME_CLIENTE'] = this.nomeCli;
    data['DATA'] = DataFormato.getDate(this.data,DataFormato.formatInsertFirebird);
    data['PONTOS_MELHORIAS'] = this.pontosMelhorias;
    data['REL_MONITOR'] = this.relMonitor;
    data['OBSERVACOES'] = this.observacoes;
    data['COMENTARIOS'] = this.comentarios;
    data['SITUACAO'] = this.situacao;
    return data;
  }

  @override
  String toString() {
    return '$id,$idCli,"${nomeCli}","${data}","${pontosMelhorias}","${relMonitor}","${observacoes}","${comentarios}"';
  }


}