import 'package:flutter/material.dart';
import 'package:microsistema/controller/armadilha_controller.dart';
import 'package:microsistema/controller/departamento_controller.dart';
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
  int codDep = 0;
  int codOs = 0;

  @override
   initState() {
    init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Armadilhas"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap : departamentoController.departamentoSelected == null ? null :() async{
              // print(armadilhaController.armadilhaSelected);
              showDialog(context: context, builder: (context) {
                return Center(child:CircularProgressIndicator());
              });
              await armadilhaController.updateArmadilha(armadilhaController.armadilhaSelected);
              Navigator.of(context).pop();
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  content: Text("Armadilha(s) do setor "
                      "${departamentoController.departamentoSelected!.nome} atualizada(s)!"),
                );
              });
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
                  armadilhaController.filterArmadilhaByDep(departamentoController.departamentoSelected!.id,departamentoController.departamentoSelected!.os);
                  codDep = departamentoController.departamentoSelected!.id!;
                  codOs = departamentoController.departamentoSelected!.os!;
                  print(armadilhaController.armadilhas);
                  listWidget();
                });
              }),
          Expanded(
            child: departamentoController.departamentoSelected == null ? Container() :
              ListView.builder(
                itemCount: armadilhaController.list.length,
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
                              child: Text("${armadilhaController.list[index].nome}")
                          ),
                          DropdownButton(
                              //key: ,
                              value: armadilhaController.list[index].status, //mapStatus[index],
                              items: armadilhaController.listStatus.map((e) {
                                return DropdownMenuItem(
                                    value: e,
                                    child: Text(e)
                                );
                              }).toList(),
                              onChanged: (value){
                                setState(() {
                                  armadilhaController.list[index].status = value.toString();
                                  armadilhaController.mapStatus[index] = value.toString();
                                  armadilhaController.armadilhaSelected = armadilhaController.list[index];
                                });
                              }),
                        ],
                      )
                    ),
                  );
                },
              )
          ),
          Card(
            child: GestureDetector(
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: listWidget() ,
                ),
              ),
              onLongPress: (){
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: Text("Legendas"),
                    // content: Container(
                    //   // child: Column(
                    //   //   mainAxisAlignment: MainAxisAlignment.center,
                    //   //   children: [
                    //   //     Card(child: Text("R - Isca Roida")),
                    //   //     Card(child: Text("D - Isca Danificada")),
                    //   //     Card(child: Text("A - Armadilha Adesiva Danificada")),
                    //   //     Card(child: Text("C - Roedor Capturado na Adesiva")),
                    //   //     Card(child: Text("X - Sem Necessidade de Reposição")),
                    //   //     Card(child: Text("P - Porta Isca Ausente")),
                    //   //     Card(child: Text("B - PRM Bloqueado")),
                    //   //     Card(child: Text("K - PRM Quebrado"))
                    //   //   ]
                    //   // ),
                    // )
                  );
                });
              },
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
              departamento: codDep,
              os: codOs
          )
          }',
          style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold))
      );
    });

    return l;
  }

  Future init() async{
    await departamentoController.getDepartamentosbyOs(widget.ordemSelected.id);
    await armadilhaController.getArmadilhas(sincronizado: false);
    setState(() {
    });
  }

}