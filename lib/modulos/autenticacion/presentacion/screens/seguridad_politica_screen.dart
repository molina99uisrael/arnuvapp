
import 'package:arnuvapp/modulos/autenticacion/presentacion/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';
import 'package:flutter/material.dart';

class SeguridadPoliticaScreen extends ConsumerWidget {
  const SeguridadPoliticaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final lregistros = ref.watch(seguridadPoliticaProvider).lregistros;

    ref.listen(seguridadPoliticaProvider, (ArnuvState? previous , ArnuvState next) {
      if ( next.errorMessage.isEmpty ) return;
      mostrarErrorSnackBar( context, next.errorMessage, ref );
    });

    return Scaffold(
      appBar: AppBar(title: Text(localizations.translate('AppTitSegPol')) ),
        body: Column(
          children: [
            DataTableArnuv(nombreTabla: "Tabla de Políticas",
            columnsName: const ['Id','Longitud','Intentos'],
            onNew: () {
              ref.watch(seguridadPoliticaProvider.notifier).limpiarRegistro();
              dialogRegister(context: context,
                children: [_Formulario( onPressedOk: () {
                  ref.watch(seguridadPoliticaProvider.notifier).guardar();
                  Navigator.pop(context);
                })],
              );
            },
            onDelete: (index) {
              aletaEliminaReg(context: context,
                onPressedOk: () {
                  ref.watch(seguridadPoliticaProvider.notifier).eliminar(lregistros[index]);
                  Navigator.pop(context);
                },
              );
            },
            onEdit: (index) {
              ref.watch(seguridadPoliticaProvider.notifier).seleccionaRegistro(lregistros[index]);
              dialogRegister(context: context,
                esregistrar: false,
                children: [_Formulario(
                    esActualizar: true,
                    onPressedOk: () {
                    ref.watch(seguridadPoliticaProvider.notifier).actualizar(lregistros[index]);
                    Navigator.pop(context);
                  }
                )],
              );
            },
            rowTablas: [...lregistros.map((e) {
                  List<Widget> lista = [];
                  lista.add(Text(e.id.toString()));
                  lista.add(Text(e.longitud.toString()));
                  lista.add(Text(e.intentos.toString()));
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
    final state = ref.watch(seguridadPoliticaProvider);
    final metodos = ref.read(seguridadPoliticaProvider.notifier);
    
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
                maxLength: 2,
                onChange: (value) => state.registro.id = int.tryParse(value) ?? 0,
                validacion: (valor) => valiacion.validarSoloNumeros(valor),
                readOnly: esActualizar,
              ),
              InputTexto(
                initialValue: state.registro.especiales.toString(),
                espacioTop: 20.0,
                textInputType: TextInputType.text,
                label: localizations.translate('lblEspeciales'),
                maxLength: 2,
                onChange: (value) => state.registro.especiales = int.tryParse(value) ?? 0,
                validacion: (valor) => valiacion.validarSoloNumeros(valor)         
              ),
              InputTexto(
                initialValue: state.registro.intentos.toString(),
                espacioTop: 20.0,
                textInputType: TextInputType.text,
                label: localizations.translate('lblIntentos'),
                maxLength: 2,
                onChange: (value) => state.registro.intentos = int.tryParse(value) ?? 0,
                validacion: (valor) => valiacion.validarSoloNumeros(valor)         
              ),
              InputTexto(
                initialValue: state.registro.longitud.toString(),
                espacioTop: 20.0,
                textInputType: TextInputType.text,
                label: localizations.translate('lblLongitud'),
                maxLength: 2,
                onChange: (value) => state.registro.longitud = int.tryParse(value) ?? 0,
                validacion: (valor) => valiacion.validarSoloNumeros(valor)         
              ),
              InputTexto(
                initialValue: state.registro.mayusculas.toString(),
                espacioTop: 20.0,
                textInputType: TextInputType.text,
                label: localizations.translate('lblMayusculas'),
                maxLength: 2,
                onChange: (value) => state.registro.mayusculas = int.tryParse(value) ?? 0,
                validacion: (valor) => valiacion.validarSoloNumeros(valor)         
              ),
              InputTexto(
                initialValue: state.registro.minusculas.toString(),
                espacioTop: 20.0,
                textInputType: TextInputType.text,
                label: localizations.translate('lblMinusculas'),
                maxLength: 2,
                onChange: (value) => state.registro.minusculas = int.tryParse(value) ?? 0,
                validacion: (valor) => valiacion.validarSoloNumeros(valor)         
              ),
              InputTexto(
                initialValue: state.registro.numeros.toString(),
                espacioTop: 20.0,
                textInputType: TextInputType.text,
                label: localizations.translate('lblNumeros'),
                maxLength: 2,
                onChange: (value) => state.registro.numeros = int.tryParse(value) ?? 0,
                validacion: (valor) => valiacion.validarSoloNumeros(valor)         
              ),
              InputTexto(
                initialValue: state.registro.tiemporegeraciontoken.toString(),
                espacioTop: 20.0,
                textInputType: TextInputType.text,
                label: localizations.translate('lblTiempoRegToken'),
                maxLength: 2,
                onChange: (value) => state.registro.tiemporegeraciontoken = int.tryParse(value) ?? 0,
                validacion: (valor) => valiacion.validarSoloNumeros(valor)         
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


