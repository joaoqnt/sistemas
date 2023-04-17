import 'package:flutter/material.dart';

class DropDownButtonWidget{
  Widget criaDDB(dynamic value,List<dynamic> list,String tipo){
    return DropdownButton(
        value: value,
        items: list.map((e){
          return DropdownMenuItem(
            value: e,
            child: Text('${e.tipo}'),
          );
        }).toList(),
        onChanged: (value) {

        });
  }
}