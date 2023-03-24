import 'package:microsistema/models/ordemServico.dart';
import 'package:microsistema/repositories/ordemServico_repository.dart';

class OrdemServicoController{
  OrdemServicoRepository repository = OrdemServicoRepository();

  List<OrdemServico> listAll(){
    return repository.listAll();
  }

  void save(OrdemServico ordemServico){
    repository.save(ordemServico);
  }

}