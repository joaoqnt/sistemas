import 'package:flutter/material.dart';
import 'package:microsistema/controller/ordemServico_controller.dart';
import 'package:microsistema/models/ordemServico.dart';
import 'package:microsistema/repositories/database_repository.dart';
import 'package:microsistema/utils/dataformato_util.dart';
import 'package:microsistema/views/avaliacao_page_view.dart';

//banco de dados sqlite
class OsPageView extends StatefulWidget {
  const OsPageView({Key? key}) : super(key: key);

  @override
  State<OsPageView> createState() => _OsPageViewState();
}

class _OsPageViewState extends State<OsPageView> {
  List<OrdemServico> ordemServicos = [];
  OrdemServicoController ordemServicoController = OrdemServicoController();
  OrdemServico? ordemSelected;
  TextEditingController? tecBusca;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Ordem de Serviço"),
          actions: [
            InkWell(
              child: Icon(Icons.refresh),
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Center(child: CircularProgressIndicator());
                    });
                ordemServicoController.sincronizado = true;
                await init();
                Navigator.of(context).pop();
              },
            )
          ],
          centerTitle: true),
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
            itemCount: ordemServicoController.filteredOrdemservicos.length,
            itemBuilder: (context, index) {
              return Card(
                child: InkWell(
                  onTap: () {
                    ordemSelected =
                        ordemServicoController.filteredOrdemservicos[index];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext) =>
                                AvaliacaoPageView(ordemSelected!)));
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
                                "${ordemServicoController.filteredOrdemservicos[index].id}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
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
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                          "${ordemServicoController.filteredOrdemservicos[index].nomeCli}",
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
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "${DataFormato.getDate(ordemServicoController.filteredOrdemservicos[index].data, DataFormato.formatDDMMYYYY)}",
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text("Ordem de Serviço"),
                                            actions: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  "Pontos de Melhoria"),
                                                      enabled: false,
                                                      initialValue:
                                                          "${ordemServicoController.filteredOrdemservicos[index].pontosMelhorias}",
                                                    ),
                                                    TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  "Relatório"),
                                                      enabled: false,
                                                      initialValue:
                                                          "${ordemServicoController.filteredOrdemservicos[index].relMonitor}",
                                                    ),
                                                    TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  "Observação"),
                                                      enabled: false,
                                                      initialValue:
                                                          "${ordemServicoController.filteredOrdemservicos[index].observacoes}",
                                                    ),
                                                    TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  "Comentários"),
                                                      enabled: false,
                                                      initialValue:
                                                          "${ordemServicoController.filteredOrdemservicos[index].comentarios}",
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ));
                                },
                                icon: const Icon(
                                  Icons.info_outline,
                                  size: 18,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
          Padding(
              padding: const EdgeInsets.all(14.0),
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    ordemServicoController.order();
                  });
                },
                child: Icon(Icons.swap_vert_outlined),
              ))
        ],
      ),
    );
  }

  Future init() async {
    DatabaseRepository db = DatabaseRepository();
    // ScriptDao script = ScriptDao();
    // int response = await db.insertData(
    //     "insert into 'ORDEM_SERVICO'(id,nome_cliente) values (3,'teste 3');");
    // print(response);
    // List<Map> select = await db.selectData("select * from 'ordem_servico';");
    // print(select);
    await ordemServicoController.getOs(sincronizado: ordemServicoController.sincronizado);
    setState(() {});
  }
}
