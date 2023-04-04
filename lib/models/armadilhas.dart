class Armadilha {
 int? id;
 String? nome;
 int? departamento;
 String? status;
 int? os;

 Armadilha({this.id, this.nome, this.status});

 Armadilha.fromJson(Map<String, dynamic> json) {
  id = json['ID'];
  nome = json['NOME'];
  departamento = json['DEPARTAMENTO'];
  status = json['STATUS'];
  os = json['OS'];
 }

 Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['ID'] = this.id;
  data['NOME'] = this.nome;
  data['DEPARTAMENTO'] = this.departamento;
  data['STATUS'] = this.status;
  data['OS'] = this.os;
  return data;
 }
 @override
  String toString() {
    // TODO: implement toString
    return '$id ,"${nome}",$departamento,"${status}",$os';
  }

}
