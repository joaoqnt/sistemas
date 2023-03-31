import 'package:microsistema/models/armadilhas.dart';

class Departamento {
  int? id;
  String? nome;
  int? os;
  List<Armadilha>? armadilhas;

  Departamento({this.id, this.nome, this.os, this.armadilhas});

  Departamento.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    nome = json['NOME'];
    os = json['OS'];
    // if (json['armadilhas'] != null) {
    //   armadilhas = <Armadilha>[];
    //   json['armadilhas'].forEach((v) {
    //     armadilhas!.add(new Armadilha.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['os'] = this.os;
    if (this.armadilhas != null) {
      data['armadilhas'] = this.armadilhas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
