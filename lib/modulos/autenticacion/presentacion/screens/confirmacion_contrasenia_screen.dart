import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/autenticacion/presentacion/providers/providers.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';


class ConfirmacionContraseniaScreen extends StatelessWidget {
  final String token;
  const ConfirmacionContraseniaScreen({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: InicioBackground(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox( height: 600 ),
                CardContainer(
                  height: 420,
                  width: (size.width > 600) ? size.width * 0.5 : size.width,
                  child: _ConfirmacionContraseniaForm(token: token),
                )  
              ],
            ),
          ),
        ),
      )
    );
  }
}

class _ConfirmacionContraseniaForm extends ConsumerWidget {
  final String token;
  const _ConfirmacionContraseniaForm({required this.token});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final stateForm = ref.watch(contraseniaFormProvider);
    final metodosForm = ref.watch(contraseniaFormProvider.notifier);
    final localizations = AppLocalizations.of(context);

    final valiacion = ValidacionesInputUtil(localizations: localizations);

    ref.listen(authProvider, (ArnuvState? previous , ArnuvState next) {
      if ( next.errorMessage.isEmpty ) return;
      mostrarErrorSnackBar( context, next.errorMessage, ref);
    });

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: stateForm.formKey,
      onChanged: metodosForm.esFormularioValido,
      child: Column(
        children: [
          Text(localizations.translate('lblConfirmacion')),
          InputTextoOculto(
            mostrarTexto: stateForm.mostrarTexto1,
            espacioTop: 20,
            label: localizations.translate('lblPasswordAnterior'),
            prefixIcon: Icons.lock_outline,
            maxLength: 16,
            onChange: metodosForm.onPasswordAnteriorChanged,
            validacion: (value) => valiacion.validarContrasenia(value),
            onTapIcon: metodosForm.onMostrarContrasenia1,
          ),
          InputTextoOculto(
            mostrarTexto: stateForm.mostrarTexto2,
            espacioTop: 20,
            label: localizations.translate('lblNuevoPass'),
            prefixIcon: Icons.lock_outline,
            maxLength: 16,
            onChange: metodosForm.onNuevoPasswordChanged,
            validacion: (value) => valiacion.validarContrasenia(value),
            onTapIcon: metodosForm.onMostrarContrasenia2,
          ),
          InputTextoOculto(
            mostrarTexto: stateForm.mostrarTexto3,
            espacioTop: 20,
            label: localizations.translate('lblConfirmarPass'),
            prefixIcon: Icons.lock_outline,
            maxLength: 16,
            onChange: metodosForm.onConfirmarPasswordChanged,
            validacion: (value) => valiacion.validarRepeticionContrasenia(value, stateForm.nuevoPassword.value),
            onTapIcon: metodosForm.onMostrarContrasenia3,
          ),
          
          BotonPrimario(
            onPressed: stateForm.esValidoForm 
              ? () => metodosForm.onFormSubmit(context, token)
              : null,
            label: localizations.translate('btnContinuar'),
            mt: 20,
          ),

        ],
      )
    );
  }
}