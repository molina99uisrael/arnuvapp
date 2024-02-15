import 'package:arnuvapp/modulos/generales/presentacion/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';
import 'package:flutter/material.dart';

class CatalogoScreen extends ConsumerWidget {
  const CatalogoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final lregistros = ref.watch(catalogProvider).lregistros;

    ref.listen(catalogProvider, (ArnuvState? previous , ArnuvState next) {
      if ( next.errorMessage.isEmpty ) return;
      mostrarErrorSnackBar( context, next.errorMessage, ref );
    });

    return Scaffold(
      appBar: AppBar(title: Text(localizations.translate('AppTitCatalogo')) ),
        body: Column(
          children: [
            DataTableArnuv(nombreTabla: "Tabla de Catalogo",
            columnsName: const ['Id Catalogo','Nombre','Activo'],
            onNew: () {
              ref.watch(catalogProvider.notifier).limpiarRegistro();
              dialogRegister(context: context,
                children: [_Formulario( onPressedOk: () {
                  ref.watch(catalogProvider.notifier).guardar();
                  Navigator.pop(context);
                })],
              );
            },
            onDelete: (index) {
              aletaEliminaReg(context: context,
                onPressedOk: () {
                  ref.watch(catalogProvider.notifier).eliminar(lregistros[index]);
                  Navigator.pop(context);
                },
              );
            },
            onEdit: (index) {
              ref.watch(catalogProvider.notifier).seleccionaRegistro(lregistros[index]);
              dialogRegister(context: context,
                esregistrar: false,
                children: [_Formulario(
                  esActualizar: true,
                  onPressedOk: () {
                    ref.watch(catalogProvider.notifier).actualizar(lregistros[index]);
                    Navigator.pop(context);
                  }
                )],
              );
            },
            rowTablas: [...lregistros.map((e) {
                  List<Widget> lista = [];
                  lista.add(Text(e.id.toString()));
                  lista.add(Text(e.nombre));
                  lista.add(Text(e.activo.toString()));
                  return lista;
                })],
            ),

          ]
        )
    );
  }
}

class _Formulario extends ConsumerWidget {

  final Function()? onPressedOk;
  final bool esActualizar;

  const _Formulario({
    required this.onPressedOk,
    this.esActualizar = false
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final localizations = AppLocalizations.of(context);
    final state = ref.watch(catalogProvider);
    final metodos = ref.read(catalogProvider.notifier);
    
    final valiacion = ValidacionesInputUtil(localizations: localizations);
    return Column(
      children: [
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: state.formKey,
          onChanged: metodos.esFormularioValido,
          child: Column(
            children: [
              InputTexto(
                initialValue: state.registro.id.toString(),
                textInputType: TextInputType.number,
                label: localizations.translate('lblCodigo'),
                maxLength: 10,
                onChange: (value) => state.registro.id = int.tryParse(value) ?? 0,
                validacion: (valor) => valiacion.validarSoloNumeros(valor),
                readOnly: true,
              ),
              InputTexto(
                initialValue: state.registro.nombre,
                espacioTop: 20.0,
                textInputType: TextInputType.text,
                label: localizations.translate('lblNombres'),
                maxLength: 100,
                onChange: (value) => state.registro.nombre = value,    
                validacion: (valor) => valiacion.validarSoloLetras(valor)         
              ),
              InputCheck(
                label: localizations.translate('lblCheckActivo'), 
                onChanged: metodos.setCheckActivo,
                initialValue: state.registro.activo,
              ),
              BotonesForm(
                esValidoForm: state.esValidoForm, 
                onPressedOk: onPressedOk
              )
              
            ],
          )
        
        )

      ],
    );
  }
}


