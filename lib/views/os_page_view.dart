import 'package:flutter/material.dart';
import 'package:microsistema/controller/ordemServico_controller.dart';
import 'package:microsistema/utils/dataformato_util.dart';
import 'package:microsistema/views/avaliacao_page_view.dart';
import 'package:microsistema/widgets/textformfield_widget.dart';

//banco de dados sqlite
class OsPageView extends StatefulWidget {
  const OsPageView({Key? key}) : super(key: key);

  @override
  State<OsPageView> createState() => _OsPageViewState();
}

class _OsPageViewState extends State<OsPageView> {
  OrdemServicoController ordemServicoController = OrdemServicoController();
  TextFormFieldWidget textFormFieldWidget = TextFormFieldWidget();
  final _searchFocusNode = FocusNode();
  int position = -1;

  @override
  void initState() {
    super.initState();
  }
// atualizar e fechar a os mesmo estando offline
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ordem de Serviço"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_outlined),
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Center(child: CircularProgressIndicator());
                  });
              await sincronize();
              Navigator.of(context).pop();
              print(ordemServicoController.filteredOrdemservicos);
              _cancelSearch();
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
                    focusNode: _searchFocusNode,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Pesquise pelo cliente/OS",
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
                          _cancelSearch();
                          ordemServicoController.ordemServicoSellected =
                              ordemServicoController
                                  .filteredOrdemservicos[index];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext) => AvaliacaoPageView(
                                      ordemServicoController
                                          .ordemServicoSellected!)
                              ),

                          );
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade50,
                                    ),
                                    constraints: const BoxConstraints(
                                        minHeight: 60, minWidth: 60),
                                    child: Center(
                                      child: Text(
                                          "${ordemServicoController.filteredOrdemservicos[index].data}",
                                          style: TextStyle(color: Color.fromRGBO(8, 8, 8, 1),)),
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
                                        "${ordemServicoController.filteredOrdemservicos[index].id}",
                                        style: TextStyle(fontSize: 16),
                                      ),
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
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text("${ordemServicoController.filteredOrdemservicos[index].situacao}",
                                          style:TextStyle(color: ordemServicoController.filteredOrdemservicos[index].situacao == 'CONCLUIDO'
                                              ? Colors.green : Colors.orange )),
                                    )
                                  ],
                                ),
                                  ordemServicoController.filteredOrdemservicos[index].situacao == 'CONCLUIDO' ?
                                  Container() :
                                  InkWell(
                                      onTap: () async {
                                        ordemServicoController.verificaStatus(ordemServicoController.filteredOrdemservicos[index]);
                                        print(ordemServicoController.filteredOrdemservicos[index]);
                                        showDialog(context: context, builder: (context) => AlertDialog(
                                            title: Text("Finalizar"),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Divider(),
                                                  ordemServicoController.valido == true ?
                                                  Text("Ao salvar, essa OS será marcada como concluida.") : Text("Preencha todas as Armadilhas"),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: ElevatedButton(
                                                          onPressed: (){
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text("Cancelar"),
                                                          style: ElevatedButton.styleFrom(
                                                              primary: Colors.red
                                                          ),
                                                        ),
                                                      ),
                                                      ordemServicoController.valido != true ? Container() :
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: ElevatedButton(
                                                            onPressed: () async{
                                                              print(ordemServicoController.filteredOrdemservicos[index]);
                                                              ordemServicoController.filteredOrdemservicos[index].pendente = true;
                                                              await ordemServicoController.updateSituacaoOrdem(os: ordemServicoController.filteredOrdemservicos[index]);
                                                              Navigator.pop(context);
                                                            },
                                                            child: Text("Salvar"),
                                                            style: ElevatedButton.styleFrom(
                                                                primary: Colors.green
                                                            )),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                        ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Finalizar",style: TextStyle(fontWeight: FontWeight.bold)),
                                      )
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
          )
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
    await ordemServicoController.updateSituacaoOrdem(listOs: ordemServicoController.filteredOrdemservicos);
    await ordemServicoController.getAllOs() == true
        ? null
        : ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {});
  }

  void _cancelSearch() {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
