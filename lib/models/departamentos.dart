import 'armadilhas.dart';

class Departamento {

  int? id;
  String? nome;
  List<Armadilha>? armadilhas = [];

  Departamento({this.id, this.nome});

  Departamento.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    nome = json['NOME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;

    return data;
  }

  @override
  String toString() {
    return '$id, "${nome}" ';
  }
}
