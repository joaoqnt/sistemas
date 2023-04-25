import 'package:flutter/material.dart';
import 'package:microsistema/controller/avaliacao_controller.dart';
import 'package:microsistema/models/ordemServico.dart';
import 'package:microsistema/widgets/dropdownbutton_widget.dart';
import 'package:microsistema/widgets/snackbar_widget.dart';
import 'package:microsistema/widgets/textformfield_widget.dart';

class AvaliacaoPageView extends StatefulWidget {
  OrdemServico ordemSelected ;

  AvaliacaoPageView(this.ordemSelected,{Key? key}) : super(key: key);

  @override
  State<AvaliacaoPageView> createState() => _AvaliacaoPageViewState();
}

class _AvaliacaoPageViewState extends State<AvaliacaoPageView> {
  AvaliacaoController avaliacaoController = AvaliacaoController();
  TextFormFieldWidget textformfield = TextFormFieldWidget();
  DropDownButtonWidget dropDownButtonWidget = DropDownButtonWidget();
  SnackBarWidget snackBarWidget = SnackBarWidget();


  void initState(){
    init();
    // _searchFocusNode.unfocus();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Controle"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                showDialog(context: context, builder: (context) => AlertDialog(
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        //Divider(),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: textformfield.criaTFF(avaliacaoController.tecPontos, "Pontos de Melhoria")
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: textformfield.criaTFF(avaliacaoController.tecRelat, "Relatório de Monitoramento")
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: textformfield.criaTFF(avaliacaoController.tecObserv, "Observações")
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: textformfield.criaTFF(avaliacaoController.tecComent, "Comentário da Contratante")
                        ),
                      ],
                    ),
                  )
                ));
              },
              icon: Icon(Icons.info_outline)
          ),
          IconButton(
            onPressed : avaliacaoController.valido == false ? null : () async{
              avaliacaoController.armadilhas.where((element) => element.pendente == 'S').forEach((arm) async{
                showDialog(
                    context: context,
                    builder: (context) {
                      return Center(child: CircularProgressIndicator());
                    });
                await avaliacaoController.updateArmadilhas(
                    arm,
                    widget.ordemSelected.id!,
                    avaliacaoController.departamentoSelected!.id!
                ) == true ? null : ScaffoldMessenger.of(context).showSnackBar(snackBarWidget.alertaInternet());
                Navigator.of(context).pop();
              });
            },
            icon: Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15)
            ),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton(
                    isExpanded: true,
                    value: avaliacaoController.departamentoSelected,
                    hint: Text("Área Programada"),
                    items: widget.ordemSelected.departamentos!.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text('${e.nome}'),
                        );
                      }).toList(),
                      onChanged:(value) async{
                        avaliacaoController.departamentoSelected = value;
                        avaliacaoController.armadilhas = avaliacaoController.departamentoSelected!.armadilhas!;
                        avaliacaoController.filterArmadilhasByStatus(status: "Todos");
                        print(avaliacaoController.verificaArmadilhasByDep(avaliacaoController.departamentoSelected!));
                        setState(() {
                          avaliacaoController.listWidget();
                        });
                      },
                  ),
                ),
                DropdownButton(
                    value:avaliacaoController.statusSelected,
                    items: avaliacaoController.listStatusFilter.map((e) {
                      return DropdownMenuItem(
                          value: e,
                          child: Text(e)
                      );
                    }).toList(),
                    onChanged: (value){
                      avaliacaoController.statusSelected = value.toString();
                      avaliacaoController.filterArmadilhasByStatus(status: value.toString());
                      setState(() {
                        print(avaliacaoController.armadilhasFiltered);
                      });
                    })
              ],
            ),
          ),
          Expanded(
              child: avaliacaoController.departamentoSelected == null ? Container() :
              ListView.builder(
                itemCount: avaliacaoController.armadilhasFiltered.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade50,
                                  ),
                                  constraints: const BoxConstraints(minHeight: 60, minWidth: 60),
                                  child: Center(
                                    child: Icon(Icons.layers)
                                  )
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "PRM ${avaliacaoController.armadilhasFiltered[index].nome}",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: DropdownButton(
                            //key: ,
                              value: avaliacaoController.armadilhasFiltered[index].status, //mapStatus[index],
                              items: avaliacaoController.listStatus.map((e) {
                                return DropdownMenuItem(
                                    value: e,
                                    child: Text(e)
                                );
                              }).toList(),
                              onChanged: (value){
                                avaliacaoController.armadilhasFiltered[index].status = value.toString();
                                avaliacaoController.armadilhasFiltered[index].pendente = 'S';
                                avaliacaoController.statusSelected != "Todos"?
                                avaliacaoController.filterArmadilhasByStatus(status: value.toString()) : null;
                                print(avaliacaoController.verificaArmadilhasByDep(avaliacaoController.departamentoSelected!));
                                setState(() {
                                });
                              }),
                        )
                      ],
                    ),
                  );
                },
              )
          ),
          GestureDetector(
            child: Card(
              child: Container(
                // height: 35,
                constraints: BoxConstraints(minHeight: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: avaliacaoController.listWidget(),
                ),
              ),
            ),
            onTap: () {
               showDialog(context: context, builder: (context) =>
                   AlertDialog(
                     title: Text("Legenda"),
                     content: SingleChildScrollView(
                       child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: const [
                             Divider(),
                             Padding(
                               padding: EdgeInsets.all(8.0),
                               child: Text("A = Armadilha Adesiva Danificada"),
                             ),
                             Padding(
                               padding: EdgeInsets.all(8.0),
                               child: Text("B = PRM Bloqueado"),
                             ),
                             Padding(
                               padding: EdgeInsets.all(8.0),
                               child: Text("C = Roedor Capturado na Adesiva"),
                             ),
                             Padding(
                               padding: EdgeInsets.all(8.0),
                               child: Text("D = Isca Danificada"),
                             ),
                             Padding(
                               padding: EdgeInsets.all(8.0),
                               child: Text("K = PRM Quebrado")
                             ),
                             Padding(
                               padding: EdgeInsets.all(8.0),
                               child: Text("P = Porca Isca Ausente"),
                             ),
                             Padding(
                               padding: EdgeInsets.all(8.0),
                               child: Text("R = Isca Roida"),
                             ),
                             Padding(
                               padding: EdgeInsets.all(8.0),
                               child: Text("X = Sem Necessidade de Reposição"),
                             ),
                           ]
                       ),
                     ),
               ));
            },
          )
        ],
      ),
    );
  }

  Future init() async{
    await avaliacaoController.getAllDep(widget.ordemSelected.id!);
    setState(() {
    });
  }
}
