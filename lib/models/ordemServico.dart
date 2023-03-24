class OrdemServico {
  int? codigo;
  int? idCli;
  String? nomeCli;
  String? data;
  String? pontosMelhorias;
  String? relMonitor;
  String? observacoes;
  String? comentarios;

  OrdemServico(
      {this.codigo,
        this.idCli,
        this.nomeCli,
        this.data,
        this.pontosMelhorias,
        this.relMonitor,
        this.observacoes,
        this.comentarios});

  OrdemServico.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    idCli = json['id_cli'];
    nomeCli = json['nome_cli'];
    data = json['data'];
    pontosMelhorias = json['pontos_melhorias'];
    relMonitor = json['rel_monitor'];
    observacoes = json['observacoes'];
    comentarios = json['comentarios'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo'] = this.codigo;
    data['id_cli'] = this.idCli;
    data['nome_cli'] = this.nomeCli;
    data['data'] = this.data;
    data['pontos_melhorias'] = this.pontosMelhorias;
    data['rel_monitor'] = this.relMonitor;
    data['observacoes'] = this.observacoes;
    data['comentarios'] = this.comentarios;
    return data;
  }

  @override
  String toString() {
    return 'OrdemServico{'
        'codigo: $codigo, idCli: $idCli, nomeCli: $nomeCli, data: $data, pontosMelhorias: $pontosMelhorias, relMonitor: $relMonitor, observacoes: $observacoes, comentarios: $comentarios}';
  }
}