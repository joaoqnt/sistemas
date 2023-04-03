import 'package:microsistema/models/ordemServico.dart';
import 'package:microsistema/repositories/database_repository.dart';
import 'package:microsistema/repositories/ordemServico_repository.dart';

class OrdemServicoController{
  OrdemServicoRepository repository = OrdemServicoRepository();
  List<OrdemServico> filteredOrdemservicos = [];
  List<OrdemServico> ordemservicos = [];
  bool isOrdered = false;
  bool sincronizado = false ;
  DatabaseRepository databaseRepository = DatabaseRepository();

  Future getOs({bool? sincronizado}) async{
    //ordemservicos =  await repository.getOs();
    if(sincronizado!){
      ordemservicos =  await repository.getOs();
      databaseRepository.deleteData("delete from 'ordem_servico'");
      save(ordemservicos);
    }else{
      List<dynamic> lista = [];
      lista = await databaseRepository.selectData("select * from 'ordem_servico'");
      print(lista);
      lista.forEach((element) {
        // OrdemServico.fromJson(element);
        ordemservicos.add(OrdemServico.fromJson(element));
      });
      // print(await databaseRepository.selectData("select * from 'ordem_servico';"));
      print("${sincronizado} na OS CONTROLLER");
    }
    filteredOrdemservicos = ordemservicos;
    print(ordemservicos);
    // databaseRepository.insertData('ordem_servico',OrdemServico.);
  }

  void save(List<OrdemServico> ordemservicos){
    ordemservicos.forEach((element) async {
      await databaseRepository.insertData('''
        insert into 'ordem_servico' (
          id,id_cliente,nome_cliente,data,pontos_melhorias,rel_monitor,observacoes,comentarios)
        values(
          ${element.toString()});''');
    });
  }
  void filterOs(String? busca){
    filteredOrdemservicos = ordemservicos.where((element) =>
        element.id.toString().contains(busca.toString()) ||
            element.nomeCli!.toLowerCase().contains(busca!.toLowerCase())).toList();
  }

  void order(){
    if(!isOrdered){
      ordemservicos.sort((OrdemServico b, OrdemServico a)=> a.id!.compareTo(b.id!));
      isOrdered = true;
    }
    else{
      ordemservicos.sort((OrdemServico a, OrdemServico b)=> a.id!.compareTo(b.id!));
      isOrdered = false;
    }
  }
}