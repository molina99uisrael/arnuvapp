

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/personas/presentacion/providers/providers.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';
import 'package:flutter/material.dart';

class UsuarioDetalleScreen extends ConsumerWidget {
  const UsuarioDetalleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final lregistros = ref.watch(usuarioDetalleProvider).lregistros;

    ref.listen(usuarioDetalleProvider, (ArnuvState? previous , ArnuvState next) {
      if ( next.errorMessage.isEmpty ) return;
      mostrarErrorSnackBar( context, next.errorMessage, ref );
    });

    return Scaffold(
      appBar: AppBar(title: Text(localizations.translate('AppTitUsuario')) ),
        body: Column(
          
          children: [
            DataTableArnuv(nombreTabla: "Tabla Usuarios",
            columnsName: const ['Id Usuario', 'Username','Nombre'],
            onNew: () {
              ref.watch(usuarioDetalleProvider.notifier).limpiarRegistro();
              dialogRegister(context: context,
                children: [_Formulario( onPressedOk: () {
                  ref.watch(usuarioDetalleProvider.notifier).guardar();
                  Navigator.pop(context);
                })],
              );
            },
            onDelete: (index) {
              aletaEliminaReg(context: context,
                onPressedOk: () {
                  ref.watch(usuarioDetalleProvider.notifier).eliminar(lregistros[index]);
                  Navigator.pop(context);
                },
              );
            },
            onEdit: (index) {
              ref.watch(usuarioDetalleProvider.notifier).seleccionaRegistro(lregistros[index]);
              dialogRegister(context: context,
                esregistrar: false,
                children: [_Formulario(
                  esActualizar: true,
                  onPressedOk: () {
                    ref.watch(usuarioDetalleProvider.notifier).actualizar(lregistros[index]);
                    Navigator.pop(context);
                  }
                )],
              );
            },
            rowTablas: [...lregistros.map((e) {
                  List<Widget> lista = [];
                  lista.add(Text(e.idusuario.toString()));
                  lista.add(Text(e.username));
                  lista.add(Text(e.idpersona.nombres));
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
    final state = ref.watch(usuarioDetalleProvider);
    final metodos = ref.read(usuarioDetalleProvider.notifier);
    
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
                initialValue: state.registro.username,
                textInputType: TextInputType.text,
                label: localizations.translate('lblUsuario'),
                maxLength: 120,
                onChange: (value) => state.registro.username = value,
                validacion: (valor) => valiacion.validarSoloLetras(valor),
                readOnly: esActualizar,
              ),
              
              InputTextoOculto(
                mostrarTexto: true,
                label: localizations.translate('lblContrasenia'),
                maxLength: 16,
                onChange: (value) => state.registro.password = value,
                readOnly: esActualizar,
                // validacion: (value) => valiacion.validarContrasenia(value),
              ),

              InputTexto(
                initialValue: state.registro.observacion,
                textInputType: TextInputType.text,
                espacioTop: 20,
                label: localizations.translate('lblObservacion'),
                maxLength: 120,
                onChange: (value) => state.registro.observacion = value,
                validacion: (valor) => valiacion.validarSoloLetras(valor)
              ),
              InputCheck(
                label: localizations.translate('lblCheckActivo'), 
                onChanged: metodos.setCheckActivo,
                initialValue: state.registro.estado,
              ),

              InputTexto(
                initialValue: state.registro.idpersona.identificacion,
                espacioTop: 20.0,
                textInputType: TextInputType.number,
                label: localizations.translate('lblIdentificacion'),
                maxLength: 100,
                onChange: (value) => state.registro.idpersona.identificacion = value,    
                validacion: (valor) => valiacion.validarSoloNumeros(valor),
                suffixIcon: state.registro.idpersona.id == 0 ? Icons.close : Icons.check,
                colorIcon: state.registro.idpersona.id == 0 ? Colors.red : Colors.green,
              ),
              BotonPrimario(
                label: localizations.translate('btnValidar'),
                py: 10,
                mt: 20,
                mb: 10,
                radius: 30,
                onPressed: () => metodos.validarIdentificacion(state.registro.idpersona.identificacion)
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

