import 'package:microsistema/infra/database_infra.dart';
import 'package:microsistema/models/produtos.dart';

class ProdutoRepository{
  DatabaseInfra database = DatabaseInfra();
  List<Produtos> _listProd = [];

  Future<List<Produtos>> getAllProdByDep(int os, int dep) async{
    List<dynamic> lista = [];
    List<Produtos> listProd = [];
    lista = await database.selectData("select * from 'PRODUTOS_DEPARTAMENTO' where OS = $os and DEPARTAMENTO = $dep order by id");
    lista.forEach((element) {
      Produtos produtos = Produtos();
      produtos.id = element['PRODUTO'];
      _listProd.where((ele) => ele.id == produtos.id).forEach((elemento) {
        // produtos.nomeComercial = elemento.nomeComercial;
        // produtos.nomeQuimico = elemento.nomeQuimico;
        produtos.quantidade = element['QUANTIDADE'];
        //print(produtos);
      });
      listProd.add(produtos);
    });
    return listProd;
  }

  Future<List<Produtos>> getAllProd() async{
    List<dynamic> lista = [];
    _listProd = [];
    lista = await database.selectData("select * from 'PRODUTOS' order by NOME_COMERCIAL");
    lista.forEach((element) {
      Produtos produtos = Produtos.fromJson(element);
      _listProd.add(produtos);
    });
    return _listProd;
  }
  Future<int> saveProduto(Map<String,dynamic> produto, String table) async {
    return await database.insertDataBinding(table, produto);
  }

  Future<void> cleanTable(String table,int os, int departamento, int produto) async{
    database.deleteData("delete from $table where OS = $os and DEPARTAMENTO = $departamento and PRODUTO = $produto;");
  }

}