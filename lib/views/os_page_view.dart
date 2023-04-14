import 'package:flutter/material.dart';
import 'package:microsistema/controller/ordemServico_controller.dart';
import 'package:microsistema/utils/dataformato_util.dart';
import 'package:microsistema/views/avaliacao_page_view.dart';

//banco de dados sqlite
class OsPageView extends StatefulWidget {
  const OsPageView({Key? key}) : super(key: key);

  @override
  State<OsPageView> createState() => _OsPageViewState();
}

class _OsPageViewState extends State<OsPageView> {
  OrdemServicoController ordemServicoController = OrdemServicoController();
  int position = -1;

  @override
  void initState() {
    //initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ordem de Serviço"),
        centerTitle: true,
        actions: [
          InkWell(
            child: Icon(Icons.refresh),
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Center(child: CircularProgressIndicator());
                  });
              await sincronize();
              Navigator.of(context).pop();
              print(ordemServicoController.filteredOrdemservicos);
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: ordemServicoController.tecBusca,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: "Pesquise",
                    ),
                    onChanged: (value) {
                      setState(() {
                        ordemServicoController.filterOs(value);
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount:
                      ordemServicoController.filteredOrdemservicos.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          ordemServicoController.ordemServicoSellected =
                              ordemServicoController
                                  .filteredOrdemservicos[index];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext) => AvaliacaoPageView(
                                      ordemServicoController
                                          .ordemServicoSellected!)));
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            //crossAxisAlignment: position != index ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromRGBO(213, 211, 211, 100)),
                                    constraints: const BoxConstraints(
                                        minHeight: 60, minWidth: 60),
                                    // alignment: AlignmentDirectional.topStart,
                                    child: Center(
                                      child: Icon(Icons.receipt_long)
                                      // Text(""
                                      //     "${DataFormato.getDate(ordemServicoController.ordemservicos[index].data, "dd/MM")}",
                                      //     style:
                                      //         TextStyle(color: Colors.lightBlue)
                                      // ),
                                    )
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${ordemServicoController.ordemservicos[index].id}",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      position != index
                                          ? Container() : Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.person,
                                                size: 12,
                                                color: Colors.grey,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Text(
                                                      "${ordemServicoController
                                                          .filteredOrdemservicos[index]
                                                          .nomeCli}",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey)),
                                                )
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                      "${DataFormato.getDate(
                                          ordemServicoController.ordemservicos[index].data, "dd/MM")}",
                                      style: TextStyle(color: Colors.blueAccent,)),
                                  IconButton(
                                      onPressed: () {
                                        if(position == index){
                                          position = -1;
                                        }else{
                                          position = index;
                                        }
                                        setState(() {
                                          print(position);
                                        });
                                      },
                                      icon: position == index ? Icon(Icons.expand_less) : Icon(Icons.expand_more)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  Future sincronize() async {
    const snackBar = SnackBar(
      content: Text("Erro ao sincronizar, verifique seu sinal de internet!"),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
    );
    await ordemServicoController.getAllOs() == true
        ? null
        : ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {});
  }

  Future initialize() async {
    await ordemServicoController.getAllBd();
    setState(() {});
  }
}
