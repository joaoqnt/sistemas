import 'package:microsistema/models/armadilhas.dart';

class Departamento {
  int? id;
  String? nome;
  int? os;

  Departamento({this.id, this.nome, this.os});

  Departamento.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    nome = json['NOME'];
    os = json['OS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['os'] = this.os;

    return data;
  }

  @override
  String toString() {
    return '$id,"${nome}",$os';
  }
}
