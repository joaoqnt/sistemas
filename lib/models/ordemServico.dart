class OrdemServico {
  int? id;
  int? idCli;
  String? nomeCli;
  DateTime? data;
  String? pontosMelhorias;
  String? relMonitor;
  String? observacoes;
  String? comentarios;

  OrdemServico(
      {this.id,
        this.idCli,
        this.nomeCli,
        this.data,
        this.pontosMelhorias,
        this.relMonitor,
        this.observacoes,
        this.comentarios});

  OrdemServico.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    idCli = json['ID_CLIENTE'];
    nomeCli = json['NOME_CLIENTE'];
    data = json['DATA'] == null ? null : DateTime.parse(json['DATA']);
    pontosMelhorias = json['PONTOS_MELHORIAS'];
    relMonitor = json['REL_MONITOR'];
    observacoes = json['OBSERVACOES'];
    comentarios = json['COMENTARIOS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['ID_CLIENTE'] = this.idCli;
    data['NOME_CLIENTE'] = this.nomeCli;
    data['DATA'] = this.data;
    data['PONTOS_MELHORIAS'] = this.pontosMelhorias;
    data['REL_MONITOR'] = this.relMonitor;
    data['OBSERVACOES'] = this.observacoes;
    data['COMENTARIOS'] = this.comentarios;
    return data;
  }

  @override
  String toString() {
    return 'OrdemServico{'
        'id: $id, idCli: $idCli, nomeCli: $nomeCli, data: $data, pontosMelhorias: $pontosMelhorias, relMonitor: $relMonitor, observacoes: $observacoes, comentarios: $comentarios}';
  }
}