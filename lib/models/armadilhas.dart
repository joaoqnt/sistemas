class Armadilha {
 int? codigo;
 String? nome;
 int? departamento;
 String? status;
 int? os;

 Armadilha({this.codigo, this.nome, this.status});

 Armadilha.fromJson(Map<String, dynamic> json) {
  codigo = json['codigo'];
  nome = json['nome'];
  departamento = json['departamento'];
  status = json['status'];
  os = json['os'];
 }

 Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['codigo'] = this.codigo;
  data['nome'] = this.nome;
  data['departamento'] = this.departamento;
  data['status'] = this.status;
  data['os'] = this.os;
  return data;
 }
 @override
  String toString() {
    // TODO: implement toString
    return "codigo : $codigo , nome : $nome, departamento : $departamento, status : $status, os : $os";
  }

}
