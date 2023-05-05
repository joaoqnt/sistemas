import 'package:flutter/material.dart';

class InfoController{
  TextEditingController tecPontos = TextEditingController();
  TextEditingController tecRelat = TextEditingController();
  TextEditingController tecObserv = TextEditingController();
  TextEditingController tecComent = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  List<String> tipos = ['P.M','R.M','OBS','C.C'];
  List<TextEditingController> controllersText = [];
  String? tipoSelected;
  List<String> textoDefault = [
    'Status : Excelente, Muito Bom!','Status : Bom, Está bom!',
    'Status: Está muito ruim!','Observação: Ficou pendente tal função!',
    'Observação: Finalizado todas as atividades!','A contratante gostou!',
    'A contratante não gostou!'
  ];
  String? textoDefaultSelected;

  TextEditingController verificaTipo(String? selecionado){
    switch(selecionado){
      case 'P.M':
        textEditingController = tecPontos;
        break;
      case 'R.M':
        textEditingController = tecRelat;
        break;
      case 'OBS':
        textEditingController = tecObserv;
        break;
      case 'C.C':
        textEditingController = tecComent;
        break;
    }
    return textEditingController;
  }

  adicionaTexto(String tipo, String texto,TextEditingController tec){
    verificaTipo(tipo).text += texto;
  }
}