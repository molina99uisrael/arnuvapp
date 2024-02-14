import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/presentacion/providers/providers.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

import 'package:arnuvapp/modulos/autenticacion/presentacion/providers/providers.dart';
import 'package:arnuvapp/modulos/autenticacion/domain/entities/rol_response.dart';

class OpcionesPermisosScreen extends ConsumerWidget {
  const OpcionesPermisosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final lregistros = ref.watch(opcionesPermisosProvider).lregistros;

    final lrol = ref.watch(rolDropdownProvider).lregistros;
    final registroSelect = ref.watch(rolDropdownProvider).registroSelect;

    ref.listen(opcionesPermisosProvider, (ArnuvState? previous , ArnuvState next) {
      if ( next.errorMessage.isEmpty ) return;
      mostrarErrorSnackBar( context, next.errorMessage, ref );
    });

    ref.listen(rolProvider, (ArnuvState? previous , ArnuvState next) {
      if ( next.errorMessage.isEmpty ) return;
      mostrarErrorSnackBar( context, next.errorMessage, ref );
    });

    return Scaffold(
      appBar: AppBar(title: Text(localizations.translate('AppTitOpcionesPermisos')) ),
        body: Column(
          children: [
            DropdownPersonalizado(
              label: localizations.translate('lblSelRol'),
              value: registroSelect.id.toString(), 
              onchange: ref.watch(rolDropdownProvider.notifier).onSeleccionChange,
              items: lrol.map<DropdownMenuItem<String>>((Rol value) {
                return DropdownMenuItem<String>(
                  value: value.id.toString(),
                  child: Text(value.nombre),
                );
              }).toList(),
              onPressed: () => ref.watch(opcionesPermisosProvider.notifier).listarPorIdRol(registroSelect.id),
            ),
            DataTableArnuv(nombreTabla: "Tabla Menu opciones",
            columnsName: const ['Id opcion', 'Pertenece','Menu','Item Menu'],
            onNew: () {
              ref.watch(opcionesPermisosProvider.notifier).limpiarRegistro();
              dialogRegister(context: context,
                children: [_Formulario( onPressedOk: () {
                  ref.watch(opcionesPermisosProvider.notifier).guardar();
                  Navigator.pop(context);
                })],
              );
            },
            onDelete: (index) {
              aletaEliminaReg(context: context,
                onPressedOk: () {
                  ref.watch(opcionesPermisosProvider.notifier).eliminar(lregistros[index]);
                  Navigator.pop(context);
                },
              );
            },
            onEdit: (index) {
              ref.watch(opcionesPermisosProvider.notifier).seleccionaRegistro(lregistros[index]);
              dialogRegister(context: context,
                esregistrar: false,
                children: [_Formulario(
                  esActualizar: true,
                  onPressedOk: () {
                    ref.watch(opcionesPermisosProvider.notifier).actualizar(lregistros[index]);
                    Navigator.pop(context);
                  }
                )],
              );
            },
            rowTablas: [...lregistros.map((e) {
                  List<Widget> lista = [];
                  lista.add(Text(e.id.idopcion.toString()));
                  lista.add(Text(e.idopcionpadre ==  null ? "" : e.idopcionpadre.toString()));
                  lista.add(Text(e.nombre ==  null ? "" : e.nombre!));
                  lista.add(Text(e.recursos ==  null ? "" : e.recursos!.nombre));
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
    final state = ref.watch(opcionesPermisosProvider);
    final metodos = ref.read(opcionesPermisosProvider.notifier);

    // Sacar informacion del dropdown por defecto
    final stateRecursos = ref.watch(recursosDropdownProvider);
    final metodosRecursos = ref.watch(recursosDropdownProvider.notifier);
    
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
                initialValue: state.registro.id.idrol.toString(),
                textInputType: TextInputType.number,
                label: localizations.translate('lblIdrol'),
                maxLength: 10,
                onChange: (value) => state.registro.id.idrol = int.tryParse(value) ?? 0,
                validacion: (valor) => valiacion.validarSoloNumeros(valor),
                readOnly: true,
              ),
              InputTexto(
                initialValue: state.registro.id.idopcion.toString(),
                textInputType: TextInputType.number,
                espacioTop: 20.0,
                label: localizations.translate('lblIdOpcion'),
                maxLength: 10,
                onChange: (value) => state.registro.id.idopcion = int.tryParse(value) ?? 0,
                validacion: (valor) => valiacion.validarSoloNumeros(valor),
                readOnly: esActualizar,
              ),
              InputTexto(
                initialValue: state.registro.idopcionpadre.toString(),
                textInputType: TextInputType.number,
                espacioTop: 20.0,
                label: localizations.translate('lblOpcionPadre'),
                maxLength: 10,
                onChange: (value) => state.registro.idopcionpadre = int.tryParse(value),
                // validacion: (valor) => valiacion.validarSoloNumeros(valor),
              ),
              InputTexto(
                initialValue: state.registro.nombre,
                espacioTop: 20.0,
                textInputType: TextInputType.text,
                label: localizations.translate('lblNombreItem'),
                maxLength: 100,
                onChange: (value) => state.registro.nombre = value,    
                // validacion: (valor) => valiacion.validarSoloLetras(valor)      
              ),
              DropdownPersonalizado(
                label: localizations.translate('lblRecurso'),
                porcentajeWidth: 0.6,
                transaparente: true,
                value: stateRecursos.registroSelect.id.toString(), 
                onchange: metodosRecursos.onSeleccionChange,
                items: stateRecursos.lregistros.map<DropdownMenuItem<String>>((Recursos value) {
                  return DropdownMenuItem<String>(
                    value: value.id.toString(),
                    child: Text(value.nombre),
                  );
                }).toList(),
              ),
              InputCheck(
                label: localizations.translate('lblCheckActivo'), 
                onChanged: metodos.setCheckActivo,
                initialValue: state.registro.activo,
              ),
              InputCheck(
                label: localizations.translate('lblCheckMostrar'), 
                onChanged: metodos.setCheckMostrar,
                initialValue: state.registro.mostar,
              ),
              InputCheck(
                label: localizations.translate('lblCheckCrear'), 
                onChanged: metodos.setCheckCrear,
                initialValue: state.registro.crear,
              ),
              InputCheck(
                label: localizations.translate('lblCheckEditar'), 
                onChanged: metodos.setCheckEditar,
                initialValue: state.registro.editar,
              ),
              InputCheck(
                label: localizations.translate('lblCheckEliminar'), 
                onChanged: metodos.setCheckEliminar,
                initialValue: state.registro.eliminar,
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


