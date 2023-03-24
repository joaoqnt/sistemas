import 'package:flutter/material.dart';
import 'package:microsistema/controller/ordemServico_controller.dart';
import 'package:microsistema/models/ordemServico.dart';
import 'package:microsistema/views/avaliacao_page_view.dart';

class OsPage extends StatefulWidget {
  const OsPage({Key? key}) : super(key: key);

  @override
  State<OsPage> createState() => _OsPageState();
}

class _OsPageState extends State<OsPage> {
  List<OrdemServico> ordemServicos = [];
  OrdemServicoController ordemServicoController = OrdemServicoController();
  OrdemServico? ordemSelected;
  TextEditingController? tecBusca;

  @override
  void initState(){
    super.initState();
    ordemServicos = ordemServicoController.listAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ordem de Serviço"),
        centerTitle: true
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: tecBusca,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: "Pesquise",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                    onChanged: (value) {

                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: ordemServicos.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          ordemSelected = ordemServicos[index];
                          // print(ordemSelected);
                          // print(DateTime.now());
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (BuildContext)=>AvaliacaoPageView(ordemSelected!))
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
                                  offset: Offset(0, 1)
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${ordemServicos[index].codigo}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:10.0,),
                                    child: Text(
                                        "${ordemServicos[index].nomeCli}",style: TextStyle(fontSize: 16)),
                                  )
                                ],
                              )
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 30.0),
                              //   child: Text(
                              //       "${ordemServicos[index].codigo}",
                              //   ),
                              // ),
                              // Expanded(
                              //     child: Text("${ordemServicos[index].nomeCli}")
                              // ),
                              // Column(
                              //   children: [
                              //     Text("${ordemServicos[index].data}",style: TextStyle(fontSize: 12),),
                              //     IconButton(onPressed: (){}, icon: Icon(Icons.expand_more))
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
              )
          )
        ],
      ),
    );
  }
}
