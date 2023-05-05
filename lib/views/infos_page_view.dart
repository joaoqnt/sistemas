import 'package:flutter/material.dart';
import 'package:microsistema/controller/info_controller.dart';
import 'package:microsistema/models/departamentos.dart';
import 'package:microsistema/models/ordemServico.dart';
import 'package:microsistema/utils/formatacao_util.dart';
import 'package:microsistema/widgets/alertdialog_widget.dart';
import 'package:microsistema/widgets/textformfield_widget.dart';

class InfoPageView extends StatefulWidget {
  OrdemServico ordemSelected;
  Departamento departamentoSelected;
  InfoPageView(this.ordemSelected,this.departamentoSelected,{Key? key}) : super(key: key);

  @override
  State<InfoPageView> createState() => _InfoPageViewState();
}

class _InfoPageViewState extends State<InfoPageView> {
  TextFormFieldWidget textFormFieldWidget = TextFormFieldWidget();
  InfoController infoController = InfoController();
  AlertDialogWidget alertDialogWidget = AlertDialogWidget();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.departamentoSelected.nome.toString().toTitleCase()}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  DropdownButton(
                      value: infoController.tipoSelected,
                      items: infoController.tipos.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text('${e}'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        infoController.tipoSelected = value;
                        print(infoController.tipoSelected);
                        setState(() {
                        });
                      }),
                  Expanded(
                    child: DropdownButton(
                        value: infoController.textoDefaultSelected,
                        isExpanded: true,
                        items: infoController.textoDefault.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text('${e}'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          infoController.textoDefaultSelected = value;
                          setState(() {

                          });
                        }),
                  ),
                  IconButton(
                      onPressed: (){
                        infoController.adicionaTexto(
                            infoController.tipoSelected!,
                            infoController.textoDefaultSelected!,
                            infoController.textEditingController);
                      },
                      icon: Icon(Icons.add))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: textFormFieldWidget.criaTFF(infoController.tecPontos, "Pontos de Melhoria",4),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: textFormFieldWidget.criaTFF(infoController.tecRelat, "Relatório de Monitoramento",4),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: textFormFieldWidget.criaTFF(infoController.tecObserv, "Observações",3),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: textFormFieldWidget.criaTFF(infoController.tecComent, "Comentários da Contratante",2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
