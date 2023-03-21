// class Armadilhas{
//  // String nome = "Armadilha";
//  // String? status;
//  // List<String> todosStatus = ['A', 'B', 'C', 'D', 'K','P','R','X'];
//
// }


class Armadilha {
 int? codigo;
 String? nome;
 String? status;

 Armadilha({this.codigo, this.nome, this.status});

 Armadilha.fromJson(Map<String, dynamic> json) {
  codigo = json['codigo'];
  nome = json['nome'];
  status = json['status'];
 }

 Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['codigo'] = this.codigo;
  data['nome'] = this.nome;
  data['status'] = this.status;
  return data;
 }
 @override
  String toString() {
    // TODO: implement toString
    return "codigo : $codigo , nome : $nome, status : $status";
  }

}
