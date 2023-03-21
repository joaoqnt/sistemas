// class Departamentos{
//   String? nome;
//   int armadilhas = 0;
//   List<String> depNomes = [ 'Administrativo', 'Comercial',  'Desenvolvimento' ];
//   Map<int,String> map = {};
//   Map<int,String> _mapAdm = {};
//   Map<int,String> _mapCom = {};
//   Map<int,String> _mapDes = {};
//   //
//   //
//   //
//
//   void verificaDep(String nome){
//     if(nome == 'Administrativo'){
//       armadilhas = 3;
//       map = _mapAdm;
//     }
//     if(nome == 'Comercial'){
//       armadilhas = 5;
//
//       map = _mapCom;
//     }
//     if(nome == 'Desenvolvimento'){
//       armadilhas = 8;
//       map = _mapDes;
//     }
//   }
//
//   int contarEventos(String armadilha){
//     int contador = 0;
//     map.forEach((key, value) {
//       if(value.toString() == armadilha)
//         contador++;
//     });
//     return contador;
//   }
// }

import 'package:microsistema/models/armadilhas.dart';

class Departamento {
  int? codigo;
  String? nome;
  List<Armadilha>? armadilhas;

  Departamento({this.codigo, this.nome, this.armadilhas});

  Departamento.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    nome = json['nome'];
    if (json['armadilhas'] != null) {
      armadilhas = <Armadilha>[];
      json['armadilhas'].forEach((v) {
        armadilhas!.add(new Armadilha.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo'] = this.codigo;
    data['nome'] = this.nome;
    if (this.armadilhas != null) {
      data['armadilhas'] = this.armadilhas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  @override
  String toString() {
    return "codigo : $codigo,\nnome : $nome,\narmadilhas : $armadilhas";
  }
}


