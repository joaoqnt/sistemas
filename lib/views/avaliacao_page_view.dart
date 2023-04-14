import 'package:flutter/material.dart';
import 'package:microsistema/controller/avaliacao_controller.dart';
import 'package:microsistema/models/ordemServico.dart';
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

  void initState(){
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Armadilha"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                showDialog(context: context, builder: (context) => AlertDialog(
                  title: Text('Monitoramento'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                  ))
                );
              },
              icon: Icon(Icons.info)
          ),
          IconButton(
            onPressed : avaliacaoController.armadilhaSelected == null ? null : () async{
              avaliacaoController.armadilhas.where((element) => element.pendente == 'S').forEach((arm) async{
                final snackBar = SnackBar(
                  content: Text("Erro ao salvar, verifique seu sinal de internet!"),
                  duration:Duration(seconds: 3),
                  backgroundColor: Colors.red,
                );
                showDialog(
                    context: context,
                    builder: (context) {
                      return Center(child: CircularProgressIndicator());
                    });
                await avaliacaoController.updateArmadilhas(
                    arm,
                    widget.ordemSelected.id!,
                    avaliacaoController.departamentoSelected!.id!
                ) == true ? null : ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //print(arm);,
                Navigator.of(context).pop();
              });
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                  value: avaliacaoController.departamentoSelected,
                  items: widget.ordemSelected.departamentos!.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text('${e.nome}'),
                    );
                  }).toList(),
                  onChanged: (value) async {
                    avaliacaoController.departamentoSelected = value;
                    avaliacaoController.armadilhas = avaliacaoController.departamentoSelected!.armadilhas!;
                    avaliacaoController.filterArmadilhasByStatus(status: "Todos");
                    print(avaliacaoController.departamentoSelected);
                    setState(() {
                      listWidget();
                    });
                  },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: DropdownButton(
                  //key: ,
                    value: avaliacaoController.statusSelected, //mapStatus[index],
                    items: avaliacaoController.listStatusFilter.map((e) {
                      return DropdownMenuItem(
                          value: e,
                          child: Text(e)
                      );
                    }).toList(),
                    onChanged: (value){
                      avaliacaoController.statusSelected = value.toString();
                      avaliacaoController.filterArmadilhasByStatus(status: avaliacaoController.statusSelected);
                      setState(() {
                        print(avaliacaoController.armadilhasFiltered);
                      });
                    }),
              )
            ],
          ),
          Expanded(
              child: avaliacaoController.departamentoSelected == null ? Container() :
              ListView.builder(
                itemCount: avaliacaoController.armadilhasFiltered!.length,
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
                                    color: Color.fromRGBO(243, 241, 241, 100),
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
                              "Armadilha ${avaliacaoController.armadilhasFiltered![index].nome}",
                              style: TextStyle(color: Colors.black,fontSize: 16),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: DropdownButton(
                            //key: ,
                              value: avaliacaoController.armadilhasFiltered![index].status, //mapStatus[index],
                              items: avaliacaoController.listStatus.map((e) {
                                return DropdownMenuItem(
                                    value: e,
                                    child: Text(e)
                                );
                              }).toList(),
                              onChanged: (value){
                                avaliacaoController.departamentoSelected!.armadilhas![index].status =
                                    value.toString();
                                avaliacaoController.armadilhaSelected =
                                avaliacaoController.departamentoSelected!.armadilhas![index];
                                avaliacaoController.armadilhaSelected!.pendente ='S';
                                avaliacaoController.statusSelected != "Todos" ?
                                avaliacaoController.filterArmadilhasByStatus(status: value.toString()) :
                                null;// avaliacaoController.filterArmadilhasByStatus(status: "Todos");
                                setState(() {

                                  print(avaliacaoController.armadilhaSelected);
                                  // print(avaliacaoController.armadilhas);
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
                  children: listWidget(),
                ),
              ),
            ),
            onTap: () {
               showDialog(context: context, builder: (context) =>
                   AlertDialog(
                     title: Text("Legenda"),
                     actions: [
                       Padding(
                         padding: const EdgeInsets.all(20.0),
                         child: Column(
                             //mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: const [
                               Text("R = Isca Roida"),
                               Text("D = Isca Danificada"),
                               Text("A = Armadilha Adesiva Danificada"),
                               Text("C = Roedor Capturado na Adesiva"),
                               Text("X = Sem Necessidade de Reposição"),
                               Text("P = Porca Isca Ausente"),
                               Text("B = PRM Bloqueado"),
                               Text("K = PRM Quebrado")
                             ]),
                       )
                     ],
               ));
            },
          )
        ],
      ),
    );
  }
  List<Widget> listWidget(){
    List<Widget> l = [];
    avaliacaoController.listStatus.forEach((element) {
      l.add(Text('$element:''${avaliacaoController.contaArmadilha(status: element)}',
          style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold))
      );
    });
    return l;
  }

  Future init() async{
    await avaliacaoController.getAllDep(widget.ordemSelected.id!);
    setState(() {
    });
  }
}
