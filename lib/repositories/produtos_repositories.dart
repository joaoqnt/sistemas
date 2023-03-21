import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:microsistema/models/respostas.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection("produtos");

class ProdutosRepositories{
  Future<void> addProduto(String nome, double preco) async{
    await _Collection.add({
      "nome": nome,
      "preco": preco
    });
  }

  //Future<void> delProduto()

  static Stream<QuerySnapshot> readProdutos(){
    CollectionReference cRef = _Collection;
    return cRef.snapshots();
  }
}