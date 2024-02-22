import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/autenticacion/presentacion/providers/providers.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';


class OlvidoContraseniaScreen extends StatelessWidget {
  
  const OlvidoContraseniaScreen({super.key});

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
                  height: 240,
                  width: (size.width > 600) ? size.width * 0.5 : size.width,
                  child: const _OlvidoContraseniaForm(),
                )  
              ],
            ),
          ),
        ),
      )
    );
  }
}

class _OlvidoContraseniaForm extends ConsumerWidget {

  const _OlvidoContraseniaForm();


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final stateForm = ref.watch(olvidoContraseniaFormProvider);
    final metodosForm = ref.watch(olvidoContraseniaFormProvider.notifier);
    final localizations = AppLocalizations.of(context);
    final themeStyle = Theme.of(context);

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
          Text(localizations.translate('lblRestablecer'), style: themeStyle.textTheme.headlineSmall),
          InputTexto(
            espacioTop: 20,
            textInputType: TextInputType.emailAddress,
            label: localizations.translate('lblEmil'),
            prefixIcon: Icons.person_outline,
            maxLength: 100,
            onChange: metodosForm.onEmailChanged,
            validacion: (valor) => valiacion.validarEmail(valor),
          ),
          
          BotonPrimario(
            onPressed: stateForm.esValidoForm 
              ? () => metodosForm.onFormSubmit(context)
              : null,
            label: localizations.translate('btnContinuar'),
            mt: 20,
          ),

        ],
      )
    );
  }
}