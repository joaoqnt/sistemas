import 'package:microsistema/models/ordemServico.dart';
import 'package:microsistema/repositories/ordemServico_repository.dart';

class OrdemServicoController{
  OrdemServicoRepository repository = OrdemServicoRepository();
  List<OrdemServico> filteredOrdemservicos = [];
  List<OrdemServico> ordemservicos = [];
  bool isOrdered = false;
  bool sincronizado = false;

  Future getOs({bool? sincronizado}) async{
    ordemservicos =  await repository.getOs(sincronizado: sincronizado);
    filteredOrdemservicos = ordemservicos;
  }

  void save(OrdemServico ordemServico){
    repository.save(ordemServico);
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