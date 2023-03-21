import 'package:flutter/material.dart';

class AlertWidgets{

  Dialogo(BuildContext context,String titulo,{String? subtitulo}) {
    Widget cancelaButton = TextButton(
      child: Text("Cancelar"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continuaButton = TextButton(
      child: Text("Continar"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("${titulo}"),
      content: subtitulo == null ? null : Text("${subtitulo}"),
      actions: [
        cancelaButton,
        continuaButton,
      ],
    );
    //exibe o diálogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}