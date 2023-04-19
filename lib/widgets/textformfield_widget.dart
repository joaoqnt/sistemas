import 'package:flutter/material.dart';

class TextFormFieldWidget{
  Widget criaTFF(TextEditingController tec,String label, {String? initialValue, Icon? prefixicon, Function? function}){
    tec.text = initialValue ?? "";
    return TextFormField(

      controller: tec,
      maxLines: null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixicon,
        border: OutlineInputBorder()
      ),
      onChanged: (value) {

        function;
      },
    );
  }

}