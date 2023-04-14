import 'package:flutter/material.dart';

class TextFormFieldWidget{
  Widget criaTFF(TextEditingController tec,String label, {String? initialValue}){
    tec.text = initialValue ?? "";
    return TextFormField(
      controller: tec,
      maxLines: null,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

}