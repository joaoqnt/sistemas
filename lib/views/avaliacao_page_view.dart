import 'package:flutter/material.dart';
import 'package:microsistema/controller/avaliacao_controller.dart';
import 'package:microsistema/models/ordemServico.dart';

class AvaliacaoPageView extends StatefulWidget {
  OrdemServico ordemSelected ;

  AvaliacaoPageView(this.ordemSelected,{Key? key}) : super(key: key);

  @override
  State<AvaliacaoPageView> createState() => _AvaliacaoPageViewState();
}

class _AvaliacaoPageViewState extends State<AvaliacaoPageView> {
  AvaliacaoController avaliacaoController = AvaliacaoController();

  void initState(){
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monitoramento"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.info)),
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
                print(avaliacaoController.departamentoSelected);
                setState(() {
                  listWidget();
                });
              },
          ),
          Expanded(
              child: avaliacaoController.departamentoSelected == null ? Container() :
              ListView.builder(
                itemCount: avaliacaoController.departamentoSelected!.armadilhas!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(213, 211, 211, 100),
                                  ),
                                  // alignment: AlignmentDirectional.center,
                                  constraints: const BoxConstraints(minHeight: 60, minWidth: 60),
                                  child: Center(
                                    child: Text(
                                      "${avaliacaoController.departamentoSelected!.armadilhas![index].nome}",
                                      style: TextStyle(color: Colors.lightBlue,fontSize: 18),
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: DropdownButton(
                            //key: ,
                              value: avaliacaoController.departamentoSelected!.armadilhas![index].status, //mapStatus[index],
                              items: avaliacaoController.listStatus.map((e) {
                                return DropdownMenuItem(
                                    value: e,
                                    child: Text(e)
                                );
                              }).toList(),
                              onChanged: (value){
                                setState(() {
                                  avaliacaoController.departamentoSelected!.armadilhas![index].status =
                                      value.toString();
                                  avaliacaoController.armadilhaSelected =
                                  avaliacaoController.departamentoSelected!.armadilhas![index];
                                  avaliacaoController.armadilhaSelected!.pendente ='S';
                                  print(avaliacaoController.armadilhaSelected);
                                  print(avaliacaoController.armadilhas);
                                });
                              }),
                        )
                      ],
                    ),
                  );
                },
              )
          ),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: listWidget(),
            ),
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
