import 'package:arnuvapp/modulos/generales/domain/entities/modulos_response.dart';
import 'package:arnuvapp/modulos/generales/presentacion/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';
import 'package:flutter/material.dart';

class RecursosScreen extends ConsumerWidget {
  const RecursosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final lregistros = ref.watch(recursosProvider).lregistros;

    final lmodulos = ref.watch(modulosDropdownProvider).lregistros;
    final registroSelect = ref.watch(modulosDropdownProvider).registroSelect;

    ref.listen(recursosProvider, (ArnuvState? previous , ArnuvState next) {
      if ( next.errorMessage.isEmpty ) return;
      mostrarErrorSnackBar( context, next.errorMessage, ref );
    });

    return Scaffold(
      appBar: AppBar(title: Text(localizations.translate('AppTitRecursos')) ),
        body: Column(
          children: [
            DropdownPersonalizado(
              label: localizations.translate('lblSelectModulo'),
              value: registroSelect.id.toString(), 
              onchange: ref.watch(modulosDropdownProvider.notifier).onSeleccionChange,
              items: lmodulos.map<DropdownMenuItem<String>>((Modulos value) {
                return DropdownMenuItem<String>(
                  value: value.id.toString(),
                  child: Text(value.nombre),
                );
              }).toList(),
              onPressed: () => ref.watch(recursosProvider.notifier).listarPorIdModulo(registroSelect.id),
            ),
            DataTableArnuv(nombreTabla: "Tabla de Recursos",
            columnsName: const ['Id Módulo', 'Id recurso','Nombre','Ruta'],
            onNew: () {
              ref.watch(recursosProvider.notifier).limpiarRegistro();
              dialogRegister(context: context,
                children: [_Formulario( onPressedOk: () {
                  ref.watch(recursosProvider.notifier).guardar();
                  Navigator.pop(context);
                })],
              );
            },
            onDelete: (index) {
              aletaEliminaReg(context: context,
                onPressedOk: () {
                  ref.watch(recursosProvider.notifier).eliminar(lregistros[index]);
                  Navigator.pop(context);
                },
              );
            },
            onEdit: (index) {
              ref.watch(recursosProvider.notifier).seleccionaRegistro(lregistros[index]);
              dialogRegister(context: context,
                esregistrar: false,
                children: [_Formulario(
                    esActualizar: true,
                    onPressedOk: () {
                    ref.watch(recursosProvider.notifier).actualizar(lregistros[index]);
                    Navigator.pop(context);
                  }
                )],
              );
            },
            rowTablas: [...lregistros.map((e) {
                  List<Widget> lista = [];
                  lista.add(Text(e.id.idmodulo.toString()));
                  lista.add(Text(e.id.idrecurso.toString()));
                  lista.add(Text(e.nombre));
                  lista.add(Text(e.ruta));
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
    final state = ref.watch(recursosProvider);
    final metodos = ref.read(recursosProvider.notifier);

    
    
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
                initialValue: state.registro.id.idmodulo.toString(),
                textInputType: TextInputType.number,
                label: localizations.translate('lblCodModulo'),
                maxLength: 10,
                onChange: (value) => state.registro.id.idmodulo = int.tryParse(value) ?? 0,
                validacion: (valor) => valiacion.validarSoloNumeros(valor),
                readOnly: true,
              ),
              InputTexto(
                initialValue: state.registro.id.idrecurso.toString(),
                textInputType: TextInputType.number,
                espacioTop: 20.0,
                label: localizations.translate('lblCodRecurso'),
                maxLength: 10,
                onChange: (value) => state.registro.id.idrecurso = int.tryParse(value) ?? 0,
                validacion: (valor) => valiacion.validarSoloNumeros(valor),
                readOnly: esActualizar,
              ),
              InputTexto(
                initialValue: state.registro.nombre,
                espacioTop: 20.0,
                textInputType: TextInputType.text,
                label: localizations.translate('lblNombres'),
                maxLength: 200,
                onChange: (value) => state.registro.nombre = value,    
                validacion: (valor) => valiacion.validarSoloLetras(valor)         
              ),
              InputTexto(
                initialValue: state.registro.ruta,
                espacioTop: 20.0,
                textInputType: TextInputType.text,
                label: localizations.translate('lblRuta'),
                maxLength: 300,
                onChange: (value) => state.registro.ruta = value,    
                // validacion: (valor) => valiacion.validarLetrasNumeros(valor)         
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


