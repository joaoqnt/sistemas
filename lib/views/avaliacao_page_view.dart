import 'package:flutter/material.dart';
import 'package:microsistema/controller/armadilha_controller.dart';
import 'package:microsistema/controller/departamento_controller.dart';
import 'package:microsistema/models/armadilhas.dart';
import 'package:microsistema/models/departamentos.dart';
import 'package:microsistema/models/ordemServico.dart';


class AvaliacaoPageView extends StatefulWidget {
  OrdemServico ordemSelected ;

  AvaliacaoPageView(this.ordemSelected,{Key? key}) : super(key: key);

  @override
  State<AvaliacaoPageView> createState() => _AvaliacaoPageViewState();
}

class _AvaliacaoPageViewState extends State<AvaliacaoPageView> {
  DepartamentoController departamentoController = DepartamentoController();
  ArmadilhaController armadilhaController = ArmadilhaController();

  @override
  void initState(){
    super.initState();
    this.departamentoController.listAll();
    departamentoController.filterByOs(widget.ordemSelected.codigo!);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Armadilhas"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              // AlertWidgets alert = AlertWidgets();
              // alert.Dialogo(context, "Salvar ${departamentoSelected!.nome} ?");
            },
            child: Icon(Icons.save),
          )
        ],
      ),
      body: Column(
        children: [
          DropdownButton(
              value: departamentoController.departamentoSelected,
              items: departamentoController.departamentos.map((e) {
                return DropdownMenuItem(
                    value: e,
                    child: Text('${e.nome}'),
                );
              }).toList(),
              onChanged: (value){
                setState(() {
                  departamentoController.departamentoSelected = value;
                  // print(departamentoController.departamentoSelected!.codigo);
                  armadilhaController.filter(
                      departamentoController.departamentoSelected!.codigo!,
                      departamentoController.departamentoSelected!.os!);
                  listWidget();
                  print(armadilhaController.armadilhas.length);
                  print(departamentoController.departamentoSelected!.os!);
                });
              }),
          Expanded(
            child: departamentoController.departamentoSelected == null ? Container() :
              ListView.builder(
                itemCount: armadilhaController.armadilhas.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                //spreadRadius: 5,
                                blurRadius: 10,
                                offset: Offset(0, 1)
                            ),
                          ],
                        ),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text("${armadilhaController.armadilhas[index].nome}")
                          ),
                          DropdownButton(
                              //key: ,
                              value: armadilhaController.armadilhas[index].status, //mapStatus[index],
                              items: armadilhaController.listStatus.map((e) {
                                return DropdownMenuItem(
                                    value: e,
                                    child: Text(e)
                                );
                              }).toList(),
                              onChanged: (value){
                                setState(() {
                                  armadilhaController.armadilhas[index].status = value.toString();
                                  armadilhaController.mapStatus[index] = value.toString();
                                  armadilhaController.armadilhaSelected = armadilhaController.armadilhas[index];
                                  print(armadilhaController.armadilhas[index]);
                                  print(armadilhaController.armadilhaSelected);
                                });
                              }),
                        ],
                      )
                    ),
                  );
                },
              )
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:listWidget() ,
            ),
          ),
        ],
      ),

    );
  }
  List<Widget> listWidget(){
    List<Widget> l = [];

    armadilhaController.listStatus.forEach((element) {
      l.add(Text(
          '$element:'
              '${armadilhaController.contaArmadilha(
              status: element,
              // departamento: armadilhaController.armadilhaSelected!.departamento,
              // os: armadilhaController.armadilhaSelected!.os
          )
          }',
          style: TextStyle(color: Colors.white))
      );
    });

    return l;
  }
}