import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/autenticacion/presentacion/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';
import 'package:flutter/material.dart';

class RolScreen extends ConsumerWidget {
  const RolScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final lregistros = ref.watch(rolProvider).lregistros;

    ref.listen(rolProvider, (ArnuvState? previous , ArnuvState next) {
      if ( next.errorMessage.isEmpty ) return;
      mostrarErrorSnackBar( context, next.errorMessage, ref );
    });

    return Scaffold(
      appBar: AppBar(title: Text(localizations.translate('AppTitRol')) ),
        body: Column(
          children: [
            DataTableArnuv(nombreTabla: "Tabla de Rol",
            columnsName: const ['Id Rol','Nombre','Activo'],
            onNew: () {
              ref.watch(rolProvider.notifier).limpiarRegistro();
              dialogRegister(context: context,
                children: [_Formulario( onPressedOk: () {
                  ref.watch(rolProvider.notifier).guardar();
                  Navigator.pop(context);
                })],
              );
            },
            onDelete: (index) {
              aletaEliminaReg(context: context,
                onPressedOk: () {
                  ref.watch(rolProvider.notifier).eliminar(lregistros[index]);
                  Navigator.pop(context);
                },
              );
            },
            onEdit: (index) {
              ref.watch(rolProvider.notifier).seleccionaRegistro(lregistros[index]);
              dialogRegister(context: context,
                esregistrar: false,
                children: [_Formulario(
                    esActualizar: true,
                    onPressedOk: () {
                    ref.watch(rolProvider.notifier).actualizar(lregistros[index]);
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
    final state = ref.watch(rolProvider);
    final metodos = ref.read(rolProvider.notifier);
    
    // Sacar informacion del dropdown por defecto
    final stateSegPolitica = ref.watch(segPoliticaDropdownProvider);
    final metodosSegPolitica = ref.watch(segPoliticaDropdownProvider.notifier);
    
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
                readOnly: esActualizar,
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
              DropdownPersonalizado(
                label: localizations.translate('lblSeguridadPol'),
                porcentajeWidth: 0.6,
                transaparente: true,
                value: stateSegPolitica.registroSelect.id.toString(), 
                onchange: metodosSegPolitica.onSeleccionChange,
                items: stateSegPolitica.lregistros.map<DropdownMenuItem<String>>((SeguridadPolitica value) {
                  return DropdownMenuItem<String>(
                    value: value.id.toString(),
                    child: Text(value.id.toString()),
                  );
                }).toList(),
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


