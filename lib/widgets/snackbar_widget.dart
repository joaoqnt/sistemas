import 'package:flutter/material.dart';

class SnackBarWidget{
  SnackBar snackbar(String text){
     SnackBar snackBar = SnackBar(
      content: Text('${text}'),
      duration:Duration(seconds: 3),
      backgroundColor: Colors.red,
    );
     return snackBar;
  }
}