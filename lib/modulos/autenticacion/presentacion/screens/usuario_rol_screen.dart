import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/autenticacion/presentacion/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';
import 'package:flutter/material.dart';

class UsuarioRolScreen extends ConsumerWidget {
  const UsuarioRolScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final lregistros = ref.watch(usuarioRolProvider).lregistros;

    final lrol = ref.watch(rolDropdownProvider).lregistros;
    final registroSelect = ref.watch(rolDropdownProvider).registroSelect;

    ref.listen(usuarioRolProvider, (ArnuvState? previous , ArnuvState next) {
      if ( next.errorMessage.isEmpty ) return;
      mostrarErrorSnackBar( context, next.errorMessage, ref );
    });

    return Scaffold(
      appBar: AppBar(title: Text(localizations.translate('AppTitUsuarioRol')) ),
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
              onPressed: () => ref.watch(usuarioRolProvider.notifier).listarPorRol(1,1, registroSelect.id),
            ),
            DataTableArnuv(nombreTabla: "Tabla de Usuario Rol",
            columnsName: const ['Rol','Username'],
            onNew: () {
              ref.watch(usuarioRolProvider.notifier).limpiarRegistro();
              dialogRegister(context: context,
                children: [_Formulario( onPressedOk: () {
                  ref.watch(usuarioRolProvider.notifier).guardar();
                  Navigator.pop(context);
                })],
              );
            },
            onDelete: (index) {
              aletaEliminaReg(context: context,
                onPressedOk: () {
                  ref.watch(usuarioRolProvider.notifier).eliminar(lregistros[index]);
                  Navigator.pop(context);
                },
              );
            },
            onEdit: (index) {
              ref.watch(usuarioRolProvider.notifier).seleccionaRegistro(lregistros[index]);
              dialogRegister(context: context,
                esregistrar: false,
                children: [_Formulario(
                    esActualizar: true,
                    onPressedOk: () {
                    ref.watch(usuarioRolProvider.notifier).actualizar(lregistros[index]);
                    Navigator.pop(context);
                  }
                )],
              );
            },
            rowTablas: [...lregistros.map((e) {
                  List<Widget> lista = [];
                  lista.add(Text(e.idrol.nombre));
                  lista.add(Text(e.idusuario.idpersona.email));
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
    final state = ref.watch(usuarioRolProvider);
    final metodos = ref.read(usuarioRolProvider.notifier);
    
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
                initialValue: state.registro.idusuario.username,
                espacioTop: 20.0,
                textInputType: TextInputType.emailAddress,
                label: localizations.translate('lblValidaUsuario'),
                maxLength: 100,
                onChange: (value) => state.registro.idusuario.idpersona.email = value,    
                validacion: (valor) => valiacion.validarEmail(valor),
                suffixIcon: state.registro.idusuario.idusuario == 0 ? Icons.close : Icons.check,
                colorIcon: state.registro.idusuario.idusuario == 0 ? Colors.red : Colors.green,      
                readOnly: esActualizar,
              ),
              BotonPrimario(
                label: localizations.translate('btnValidar'),
                py: 10,
                mt: 20,
                mb: 10,
                radius: 30,
                onPressed: () => metodos.validarEmail(state.registro.idusuario.idpersona.email)
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


