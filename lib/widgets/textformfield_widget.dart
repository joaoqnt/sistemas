import 'package:flutter/material.dart';

class TextFormFieldWidget{
  Widget criaTFF(
      TextEditingController tec,String label,int lineSize,
      {String? initialValue, Icon? prefixicon, Function? function, String? hint, FocusNode? focus}){
    tec.text = initialValue ?? "";
    return TextFormField(
      controller: tec,
      maxLines: null,
      minLines: lineSize,
      focusNode: focus,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        function;
      },
    );
  }

}