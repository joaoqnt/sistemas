import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:microsistema/repositories/produtos_repositories.dart';
import 'package:microsistema/services/firebase_crud.dart';

void main(){

}

class ProdutoPage extends StatefulWidget {
  const ProdutoPage({Key? key}) : super(key: key);

  @override
  State<ProdutoPage> createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  final Stream<QuerySnapshot> collectionReference = FirebaseCrud.readProdutos();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _tecNome = TextEditingController();
  TextEditingController _tecPreco = TextEditingController();
  ProdutosRepositories _produtosRepositories = ProdutosRepositories();
  int _itemSelecionado = -1;
  //String textoAlerta;

  Future alert(bool _edita){

    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("${_edita ? "Editar Produto":"Cadastrar Produto"}"),
          content: Form(
              key: _formKey,
              child: Container(
                height: 267,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: _tecNome,
                        decoration: const InputDecoration(
                            border:OutlineInputBorder(borderRadius: BorderRadius.horizontal()),
                            labelText: "Nome"
                        ),
                        validator: (value) {
                          if(value!.isNotEmpty){
                            return null;
                          }else{
                            return "O nome não pode ser vazio";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                          controller: _tecPreco,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                              border:OutlineInputBorder(borderRadius: BorderRadius.horizontal()),
                              labelText: "Preco"
                          ),
                          validator: (value) {
                            if(value!.isNotEmpty){
                              return null;
                            }else{
                              return "O preço não pode ser vazio";
                            }
                          }
                      ),

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton.icon(
                            onPressed: () async{
                              if(_formKey.currentState!.validate()){
                                //_formKey.currentState!.save();
                                await _produtosRepositories.addProduto(_tecNome.text,double.parse(_tecPreco.text));
                                _tecNome.text = "";
                                _tecPreco.text = "";
                                Navigator.of(context).pop();
                              }
                            },
                            icon: Icon(Icons.save),
                            label: Text("Salvar"),
                            style: ElevatedButton.styleFrom(primary: Colors.green),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.close),
                          label: Text("Fechar"),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produtos"),
        centerTitle: true,
        actions: [
            IconButton(
                onPressed: (){
                  alert(false);
                },
                icon: Icon(Icons.add))
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: (){
      //
      //     },
      //     child: Icon(Icons.add),
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left:5,right: 5,top:8),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: collectionReference,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData){
                    final snap = snapshot.data!.docs;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snap.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if(_itemSelecionado == index){
                                  _itemSelecionado = -1;
                                }
                              });
                            },
                            onLongPress: () {
                              setState(() {
                                if(_itemSelecionado == index){
                                  _itemSelecionado = -1;
                                }else{
                                  _itemSelecionado = index;
                                }
                              });
                            },
                            child: Container(
                              height: 80,
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: _itemSelecionado == index ? Colors.blue.shade200 : Colors.white,
                                borderRadius: BorderRadius.circular(3),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1, 0),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 8,top: 8),
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                        "Nome:",
                                        style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 8, top: 10),
                                        alignment:Alignment.centerLeft,
                                        child: Text(
                                            snap[index]["nome"] + " | ",
                                            style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(right: 8, top: 10),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              "R\$: " +
                                               "${snap[index]["preco"].toString()}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  //fontWeight: FontWeight.bold,
                                                  color: Colors.green.shade600
                                              ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 8),
                                        child: IconButton(
                                            onPressed: (){
                                              alert(true);
                                            },
                                            icon:Icon(Icons.edit_outlined,),
                                            alignment: Alignment.centerRight,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: (){},
                                          icon: Icon(Icons.delete_outline))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
            )
          ],
        ),
      ),
    );
  }
}
