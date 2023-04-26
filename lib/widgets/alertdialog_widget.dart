import 'package:flutter/material.dart';
import 'package:microsistema/controller/ordemServico_controller.dart';

class AlertDialogWidget{
  ConfirmacaoOs(BuildContext context, int index,OrdemServicoController ordemServicoController){
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
  }
}