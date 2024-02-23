import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/autenticacion/presentacion/providers/providers.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  height: 340,
                  width: (size.width > 600) ? size.width * 0.5 : size.width,
                  child: const _LoginForm(),
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
    final loginMetodosForm = ref.watch(loginFormProvider.notifier);
    final localizations = AppLocalizations.of(context);

    final valiacion = ValidacionesInputUtil(localizations: localizations);

    ref.listen(authProvider, (ArnuvState? previous , ArnuvState next) {
      if ( next.errorMessage.isEmpty ) return;
      mostrarErrorSnackBar( context, next.errorMessage, ref);
    });

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: loginForm.formKey,
      onChanged: loginMetodosForm.esFormularioValido,
      child: Column(
        children: [
          const SizedBox(height: 10),
          InputTexto(
            textInputType: TextInputType.emailAddress,
            label: localizations.translate('lblEmil'),
            prefixIcon: Icons.person_outline,
            maxLength: 100,
            onChange: loginMetodosForm.onEmailChange,
            validacion: (valor) => valiacion.validarEmail(valor),
          ),
          const SizedBox(height: 20),
          InputTextoOculto(
            mostrarTexto: loginForm.mostrarTextoContrasenia,
            label: localizations.translate('lblContrasenia'),
            prefixIcon: Icons.lock_outline,
            maxLength: 16,
            onChange: loginMetodosForm.onPasswordChanged,
            validacion: (value) => valiacion.validarContrasenia(value),
            onTapIcon: loginMetodosForm.onMostrarContrasenia,
          ),

          BotonTransparente(
            mainAxisAlignment: MainAxisAlignment.end,
            mt: 25,
            onTap: () => context.push(ConstRoutes.RESTABLECER_CONTRASENIA),
            label: localizations.translate('lblOlvidarContrasenia'),
          ),
          
          BotonPrimario(
            onPressed: loginForm.esValido 
              ? () => loginMetodosForm.onFormSubmit(context)
              : null,
            label: localizations.translate('btnLogin'),
            mt: 20,
          ),

        ],
      )
    );
  }
}