import 'package:flutter/material.dart';
import 'package:microsistema/controller/armadilha_controller.dart';
import 'package:microsistema/controller/departamento_controller.dart';
import 'package:microsistema/models/armadilhas.dart';
import 'package:microsistema/models/departamentos.dart';


class AvaliacaoPageView extends StatefulWidget {
  const AvaliacaoPageView({Key? key}) : super(key: key);

  @override
  State<AvaliacaoPageView> createState() => _AvaliacaoPageViewState();
}

class _AvaliacaoPageViewState extends State<AvaliacaoPageView> {
  Departamento? departamentoSelected ;
  List<Departamento> departamentos = [];
  DepartamentoController departamentoController = DepartamentoController();
  Armadilha? armadilhaSelected;
  ArmadilhaController armadilhaController = ArmadilhaController();

  @override
  void initState(){
    super.initState();
    departamentos = this.departamentoController.listAll();
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
              print(departamentoSelected);
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
              value: departamentoSelected,
              items: departamentos.map((e) {
                return DropdownMenuItem(
                    value: e,
                    child: Text('${e.nome}')
                );
              }).toList(),
              onChanged: (value){
                setState(() {
                  departamentoSelected = value;
                  listWidget();
                });
              }),
          Expanded(
            child: departamentoSelected == null ? Container() :
              ListView.builder(
                itemCount: departamentoSelected?.armadilhas!.length,
                itemBuilder: (context, index) {
                  Armadilha armadilha = departamentoSelected!.armadilhas![index];

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
                              child: Text("${armadilha.nome}")
                          ),
                          DropdownButton(
                              //key: ,
                              value: armadilha.status, //mapStatus[index],
                              items: armadilhaController.listStatus.map((e) {
                                return DropdownMenuItem(
                                    value: e,
                                    child: Text(e)
                                );
                              }).toList(),
                              onChanged: (value){
                                setState(() {
                                  armadilha.status = value.toString();
                                  armadilhaController.mapStatus[index] = value.toString();
                                  // departamentoSelected = departamentoController.updateArmadilhaPorDepartamento(value.toString(), departamentoSelected!.codigo!, armadilha.codigo!);
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
          '$element:${departamentoController.contaArmadilha(status: element, departamento: departamentoSelected)}',
          style: TextStyle(color: Colors.white))
      );
    });

    return l;
  }
}