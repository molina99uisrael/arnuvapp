import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/autenticacion/presentacion/providers/providers.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const Scaffold(
        body: InicioBackground(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                SizedBox( height: 200 ),
                
                CardContainer(
                  height: 270,
                  child: _LoginForm(),
                )  
              ],
            ),
          ),
        ),
      )
    );
  }
}

class _LoginForm extends ConsumerWidget {

  const _LoginForm();


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final loginForm = ref.watch(loginFormProvider);
    final localizations = AppLocalizations.of(context);

    final valiacion = ValidacionesInputUtil(localizations: localizations);

    ref.listen(authProvider, (ArnuvState? previous , ArnuvState next) {
      if ( next.errorMessage.isEmpty ) return;
      mostrarErrorSnackBar( context, next.errorMessage, ref);
    });

    return Column(
      children: [
        const SizedBox(height: 10),
        InputTexto(
          textInputType: TextInputType.emailAddress,
          label: localizations.translate('lblEmil'),
          prefixIcon: Icons.person_outline,
          maxLength: 100,
          onChange: ref.read(loginFormProvider.notifier).onEmailChange,
          validacion: (valor) => valiacion.validarEmail(valor),
        ),
        const SizedBox(height: 20),
        InputTextoOculto(
          mostrarTexto: ref.read(loginFormProvider).mostrarTextoContrasenia,
          label: localizations.translate('lblContrasenia'),
          prefixIcon: Icons.lock_outline,
          maxLength: 16,
          onChange: ref.read(loginFormProvider.notifier).onPasswordChanged,
          validacion: (value) => valiacion.validarContrasenia(value),
          onTapIcon: ref.read(loginFormProvider.notifier).onMostrarContrasenia,
        ),
        
        BotonPrimario(
          onPressed: loginForm.esValido 
            ? () => ref.read(loginFormProvider.notifier).onFormSubmit(context)
            : null,
          label: localizations.translate('btnLogin'),
          mt: 20,
        ),

      ],
    );
  }
}