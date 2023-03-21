import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Produtos {
  String? id;
  String? nome;
  Double? preco;

  Produtos({
    this.id,
    required this.nome,
    required this.preco
  });

  toJson(){
    return{"nome": nome, "preco" : preco};
  }

  factory Produtos.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> documento){
    final data = documento.data();
    return Produtos(
        id: documento.id,
        nome: data!["nome"],
        preco: data["preco"]
    );
  }
}