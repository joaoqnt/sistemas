import 'package:flutter/material.dart';
import 'package:microsistema/controller/ordemServico_controller.dart';
import 'package:microsistema/utils/dataformato_util.dart';
import 'package:microsistema/views/avaliacao_page_view.dart';
import 'package:microsistema/widgets/alertdialog_widget.dart';
import 'package:microsistema/widgets/snackbar_widget.dart';
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
  AlertDialogWidget alertDialogWidget = AlertDialogWidget();
  SnackBarWidget snackBarWidget = SnackBarWidget();
  DataFormato dataFormato = DataFormato();
  final _searchFocusNode = FocusNode();
  int position = -1;

  @override
  void initState() {
    init();
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
                  child:
                  TextFormField(
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
                          ordemServicoController.filteredOrdemservicos[index];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext) =>
                                      AvaliacaoPageView(ordemServicoController.ordemServicoSellected!))
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
                                          "${DataFormato.getDate(ordemServicoController.filteredOrdemservicos[index].data,"dd/MM")}",
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          constraints: BoxConstraints(minWidth: 20,minHeight: 10),
                                          decoration: BoxDecoration(color: ordemServicoController.filteredOrdemservicos[index].situacao == 'CONCLUIDO'
                                              ? Colors.green : Colors.orange,shape: BoxShape.circle ),
                                          child: Text("${ordemServicoController.filteredOrdemservicos[index].situacao == "CONCLUIDO" ? "C" : "P"}",
                                              style:TextStyle(color: Colors.white)),
                                        ),
                                      )
                                    ],
                                  ),
                                  ordemServicoController.filteredOrdemservicos[index].situacao == 'CONCLUIDO' ?
                                  Container() :
                                  InkWell(
                                      onTap: () {
                                        ordemServicoController.verificaStatus(ordemServicoController.filteredOrdemservicos[index]);
                                        alertDialogWidget.ConfirmacaoOs(context, index,ordemServicoController);
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Finalizar",
                                            style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                color: Colors.blue)),
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ordemServicoController.orderBy();
          setState(() {});
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.swap_vert_outlined),
      ),
    );
  }
  Future sincronize() async {
    await ordemServicoController.saveAllArmadilhasByOs(ordemServicoController.filteredOrdemservicos);
    await ordemServicoController.updateSituacaoOrdem(listOs: ordemServicoController.filteredOrdemservicos);
    await ordemServicoController.getAllOs() == true
        ? null
        : ScaffoldMessenger.of(context).showSnackBar(snackBarWidget.snackbar("Erro ao sincronizar, verifique sua internet!"));
    setState((){});
  }

  void _cancelSearch() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Future init() async{
    await ordemServicoController.getAllBd();
    print("inicio");
    setState(() {
    });
  }
}
