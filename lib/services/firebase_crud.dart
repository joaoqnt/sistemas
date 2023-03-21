import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:microsistema/models/respostas.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection("produtos");

class FirebaseCrud{
  static Future<Respostas> addProduto(String nome, Double preco) async{
    Respostas respostas = Respostas();
    DocumentReference documentReference = _Collection.doc();
    Map<String,dynamic> data = <String,dynamic>{
      "nome" : nome,
      "preco": preco
    };

    var resultado = await documentReference.set(data).whenComplete((){
      respostas.codigo = 200;
      respostas.mensagem = "Produto adicionado com sucesso!";
    }).catchError((e){
      respostas.codigo = 500;
      respostas.mensagem = e;
    });

    return respostas;
  }

  static Stream<QuerySnapshot> readProdutos(){
    CollectionReference cRef = _Collection;
    return cRef.snapshots();
  }
}