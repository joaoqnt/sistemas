import 'package:flutter/material.dart';

class DropDownButtonWidget{
  Widget criaDDB(dynamic value,List<dynamic> list, {dynamic? tipo}){
    return DropdownButton(
        value: value,
        items: list.map((e){
          return DropdownMenuItem(
            value: e,
            child: Text('${tipo == 'N' ? e.nome : e.status}'),
          );
        }).toList(),
        onChanged: (value) {

        });
  }
}