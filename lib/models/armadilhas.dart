class Armadilha {
  int? id;
  String? nome;
  String? status;
  String? pendente;

  Armadilha({this.id, this.nome, this.status, this.pendente});

  Armadilha.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    nome = json['NOME'];
    status = json['STATUS'];
    pendente = json['PENDENTE'];
  }

  Map<String, dynamic> toJson({int? os,int? departamento}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['NOME'] = this.nome;
    data['OS'] = os;
    data['DEPARTAMENTO'] = departamento;
    data['STATUS'] = this.status;
    data['PENDENTE'] = this.pendente;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '$id ,"${nome}","${status}","${pendente}"';
  }
}
