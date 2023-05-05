class Produtos {
  int? id;
  String? nomeComercial;
  String? nomeQuimico;
  double? quantidade;
  String? pendente;

  Produtos({this.id, this.nomeComercial, this.nomeQuimico});

  Produtos.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    nomeComercial = json['NOME_COMERCIAL'];
    nomeQuimico = json['NOME_QUIMICO'];
    quantidade = json['QUANTIDADE'];
    pendente = json['PENDENTE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['NOME_COMERCIAL'] = this.nomeComercial;
    data['NOME_QUIMICO'] = this.nomeQuimico;
    data['QUANTIDADE'] = this.quantidade;
    data['PENDENTE'] = this.pendente;
    return data;
  }

  String toString() {
    return 'id: $id, nomeComercial: $nomeComercial, nomeQuimico: $nomeQuimico, quantidade: $quantidade, pendente: $pendente';
  }
}
