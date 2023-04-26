import 'package:flutter/material.dart';

class TextFormFieldWidget{
  Widget criaTFF(
      TextEditingController tec,String label,
      {String? initialValue, Icon? prefixicon, Function? function, String? hint, FocusNode? focus}){
    tec.text = initialValue ?? "";
    return TextFormField(
      controller: tec,
      maxLines: null,
      focusNode: focus,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixicon,
        hintText: hint,
        border: OutlineInputBorder()
      ),
      onChanged: (value) {
        function;
      },
    );
  }

}