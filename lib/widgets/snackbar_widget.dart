import 'package:flutter/material.dart';

class SnackBarWidget{
  SnackBar alertaInternet(){
     const snackBar = SnackBar(
      content: Text("Erro ao salvar, verifique seu sinal de internet!"),
      duration:Duration(seconds: 3),
      backgroundColor: Colors.red,
    );
     return snackBar;
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return Center(child: CircularProgressIndicator());
    //     });
  }
}