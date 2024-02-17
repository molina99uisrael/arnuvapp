import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:arnuvapp/modulos/autenticacion/presentacion/providers/autenticacion_provider.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final contraseniaFormProvider = StateNotifierProvider.autoDispose<ContraseniaFormNotifier,ContraseniaFormState>((ref) {

  final confirmacionCallback = ref.watch(authProvider.notifier).confirmacionContrasenia;

  return ContraseniaFormNotifier(
    confirmacionCallback:confirmacionCallback
  );
});


//! 2 - Como implementamos un notifier
class ContraseniaFormNotifier extends StateNotifier<ContraseniaFormState> {

  final Function(String,String,String,String, BuildContext context) confirmacionCallback;

  ContraseniaFormNotifier({
    required this.confirmacionCallback,
  }): super( ContraseniaFormState( formKey: GlobalKey<FormState>() ) );

  onPasswordAnteriorChanged( String value ) {
    final passwordAnterior = Password.dirty(value);
    state = state.copyWith(
      confirmaPassword: state.confirmaPassword,
      nuevoPassword: state.nuevoPassword,
      passwordAnterior: passwordAnterior,
      esValidoForm: Formz.validate([ passwordAnterior, state.nuevoPassword, state.confirmaPassword ])
    );
  }

  onNuevoPasswordChanged( String value ) {
    final nuevoPassword = Password.dirty(value);
    state = state.copyWith(
      confirmaPassword: state.confirmaPassword,
      nuevoPassword: nuevoPassword,
      passwordAnterior: state.passwordAnterior,
      esValidoForm: Formz.validate([ nuevoPassword, state.passwordAnterior, state.confirmaPassword ])
    );
  }

  onConfirmarPasswordChanged( String value ) {
    final confirmaPassword = Password.dirty(value);
    if (confirmaPassword.value != state.nuevoPassword.value) {
      state = state.copyWith(
        confirmaPassword: confirmaPassword,
        nuevoPassword: state.nuevoPassword,
        passwordAnterior: state.passwordAnterior,
        esValidoForm: false
      );
      return;
    }
    state = state.copyWith(
      confirmaPassword: confirmaPassword,
      nuevoPassword: state.nuevoPassword,
      passwordAnterior: state.passwordAnterior,
      esValidoForm: Formz.validate([ confirmaPassword, state.passwordAnterior, state.nuevoPassword ])
    );
  }

  onMostrarContrasenia1() {
    state = state.copyWith( 
      confirmaPassword: state.confirmaPassword,
      nuevoPassword: state.nuevoPassword,
      passwordAnterior: state.passwordAnterior,
      mostrarTexto1: !state.mostrarTexto1 );
  }
  
  onMostrarContrasenia2() {
    state = state.copyWith( 
      confirmaPassword: state.confirmaPassword,
      nuevoPassword: state.nuevoPassword,
      passwordAnterior: state.passwordAnterior,
      mostrarTexto2: !state.mostrarTexto2 );
  }

  onMostrarContrasenia3() {
    state = state.copyWith( 
      confirmaPassword: state.confirmaPassword,
      nuevoPassword: state.nuevoPassword,
      passwordAnterior: state.passwordAnterior,
      mostrarTexto3: !state.mostrarTexto3 );
  }

  onFormSubmit(BuildContext context, String token) async {
    _touchEveryField();

    if ( !state.esValidoForm ) return;

    await confirmacionCallback( token, 
      ArnuvUtils.hashSHA256(state.passwordAnterior.value), 
      ArnuvUtils.hashSHA256(state.nuevoPassword.value), 
      ArnuvUtils.hashSHA256(state.confirmaPassword.value), 
      context);

  }

  _touchEveryField() {
    final passwordAnterior = Password.dirty(state.passwordAnterior.value);
    final nuevoPassword = Password.dirty(state.nuevoPassword.value);
    final confirmaPassword = Password.dirty(state.confirmaPassword.value);

    state = state.copyWith(
      passwordAnterior: passwordAnterior,
      nuevoPassword: nuevoPassword,
      confirmaPassword: confirmaPassword,
      esValidoForm: Formz.validate([ passwordAnterior, nuevoPassword, confirmaPassword])
    );

  }

  esFormularioValido() {
    state = state.copyWith( esValidoForm: false );
    if (state.formKey.currentState?.validate() != true) return;
    state = state.copyWith( esValidoForm: true );
  }

}


//! 1 - State del provider
class ContraseniaFormState {

  final bool esValidoForm;
  final Password passwordAnterior;
  final Password nuevoPassword;
  final Password confirmaPassword;
  final bool mostrarTexto1;
  final bool mostrarTexto2;
  final bool mostrarTexto3;
  GlobalKey<FormState> formKey;

  ContraseniaFormState({
    this.esValidoForm = false,
    this.passwordAnterior = const Password.pure(),
    this.nuevoPassword = const Password.pure(),
    this.confirmaPassword = const Password.pure(),
    this.mostrarTexto1 = true,
    this.mostrarTexto2 = true,
    this.mostrarTexto3 = true,
    required this.formKey,
  });

  ContraseniaFormState copyWith({
    bool? esValidoForm,
    Password? passwordAnterior,
    Password? nuevoPassword,
    Password? confirmaPassword,
    bool? mostrarTexto1,
    bool? mostrarTexto2,
    bool? mostrarTexto3,
    GlobalKey<FormState>? formKey
  }) => ContraseniaFormState(
    esValidoForm: esValidoForm ?? this.esValidoForm,
    passwordAnterior: passwordAnterior ?? this.passwordAnterior,
    nuevoPassword: nuevoPassword ?? this.nuevoPassword,
    confirmaPassword: confirmaPassword ?? this.confirmaPassword,
    mostrarTexto1: mostrarTexto1 ?? this.mostrarTexto1,
    mostrarTexto2: mostrarTexto2 ?? this.mostrarTexto2,
    mostrarTexto3: mostrarTexto3 ?? this.mostrarTexto3,
    formKey: formKey ?? this.formKey,
  );

}
