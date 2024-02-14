import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:arnuvapp/modulos/autenticacion/presentacion/providers/autenticacion_provider.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final loginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier,LoginFormState>((ref) {

  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;

  return LoginFormNotifier(
    loginUserCallback:loginUserCallback
  );
});


//! 2 - Como implementamos un notifier
class LoginFormNotifier extends StateNotifier<LoginFormState> {

  final Function(String, String, dynamic context) loginUserCallback;

  LoginFormNotifier({
    required this.loginUserCallback,
  }): super( LoginFormState() );
  
  onEmailChange( String value ) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      esValido: Formz.validate([ newEmail, state.password ])
    );
  }  

  onPasswordChanged( String value ) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      esValido: Formz.validate([ newPassword, state.email ])
    );
  }

  onMostrarContrasenia() {
    state = state.copyWith(
      mostrarTextoContrasenia: !state.mostrarTextoContrasenia
    );
  }

  onFormSubmit(context) async {
    _touchEveryField();

    if ( !state.esValido ) return;

    await loginUserCallback( state.email.value, ArnuvUtils.hashSHA256(state.password.value), context);

  }

  _touchEveryField() {

    final email    = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      email: email,
      password: password,
      esValido: Formz.validate([ email, password ])
    );

  }

}


//! 1 - State del provider
class LoginFormState {

  final bool esValido;
  final Email email;
  final Password password;
  final bool mostrarTextoContrasenia;

  LoginFormState({
    this.esValido = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.mostrarTextoContrasenia = true,
  });

  LoginFormState copyWith({
    bool? esAceptoTerminos,
    bool? esValido,
    Email? email,
    Password? password,
    bool? mostrarTextoContrasenia
  }) => LoginFormState(
    esValido: esValido ?? this.esValido,
    email: email ?? this.email,
    password: password ?? this.password,
    mostrarTextoContrasenia: mostrarTextoContrasenia ?? this.mostrarTextoContrasenia,
  );

}
