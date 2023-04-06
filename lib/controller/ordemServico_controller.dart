import 'package:microsistema/models/ordemServico.dart';
import 'package:microsistema/repositories/ordemServico_repository.dart';

class OrdemServicoController{
  OrdemServicoRepository repository = OrdemServicoRepository();
  List<OrdemServico> ordemservicos = [];
  OrdemServico? ordemServicoSellected;
  bool? sincronizado;

  Future<bool> getAllOs() async {
    try {
      bool ret = await repository.getAllOsApi();
      ordemservicos = await repository.getAllOsBd();
      sincronizado = true;
    }catch(e) {
      ordemservicos = await repository.getAllOsBd();
      sincronizado = false;
    }

    return sincronizado!;
  }

}