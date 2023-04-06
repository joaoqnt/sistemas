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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController tecBusca = TextEditingController();
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
              await init();
              Navigator.of(context).pop();
              print(ordemServicoController.ordemservicos);
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
                  child: TextField(
                    controller: tecBusca,
                    //keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: "Pesquise",
                    ),
                    onChanged: (value) {
                      setState(() {
                        // ordemServicoController.filterOs(value);
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: ordemServicoController.ordemservicos.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          ordemServicoController.ordemServicoSellected = ordemServicoController.ordemservicos[index];
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext) =>
                                  AvaliacaoPageView(ordemServicoController.ordemServicoSellected!)
                              )
                          );
                        },
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
                                  offset: Offset(0, 1)),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${ordemServicoController
                                          .ordemservicos[index].id}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 7.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            size: 12,
                                            color: Colors.grey,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                                "${ordemServicoController
                                                    .ordemservicos[index]
                                                    .nomeCli}",
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_month,
                                            size: 12, color: Colors.grey),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0),
                                          child: Text(
                                            "${DataFormato.getDate(
                                                ordemServicoController
                                                    .ordemservicos[index].data,
                                                DataFormato.formatDDMMYYYY)}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
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

  Future init() async {
    final snackBar = SnackBar(
      content: Text("Erro ao sincronizar, verifique seu sinal de internet!"),
      duration:Duration(seconds: 3),
      backgroundColor: Colors.red,
    );
    await ordemServicoController.getAllOs() == true ? null : ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setState(() {});
  }
}
