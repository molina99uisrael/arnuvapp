import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:arnuvapp/modulos/autenticacion/presentacion/providers/autenticacion_provider.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final olvidoContraseniaFormProvider = StateNotifierProvider.autoDispose<OlvidoContraseniaFormNotifier,OlvidoContraseniaFormState>((ref) {

  final olvidoPasswordCallback = ref.watch(authProvider.notifier).olvidoContrasenia;

  return OlvidoContraseniaFormNotifier(
    olvidoPasswordCallback:olvidoPasswordCallback
  );
});


//! 2 - Como implementamos un notifier
class OlvidoContraseniaFormNotifier extends StateNotifier<OlvidoContraseniaFormState> {

  final Function(String, BuildContext context) olvidoPasswordCallback;

  OlvidoContraseniaFormNotifier({
    required this.olvidoPasswordCallback,
  }): super( OlvidoContraseniaFormState( formKey: GlobalKey<FormState>() ) );

  onEmailChanged( String value ) {
    final email = Email.dirty(value);
    state = state.copyWith(
      email: email,
      esValidoForm: Formz.validate([ email ])
    );
  } 

  onFormSubmit(BuildContext context) async {
    _touchEveryField();

    if ( !state.esValidoForm ) return;

    await olvidoPasswordCallback( state.email.value, context);

  }

  _touchEveryField() {
    final emailvalor = Email.dirty(state.email.value);
    
    state = state.copyWith(
      email: state.email,
      esValidoForm: Formz.validate([ emailvalor])
    );

  }

  esFormularioValido() {
    state = state.copyWith( esValidoForm: false );
    if (state.formKey.currentState?.validate() != true) return;
    state = state.copyWith( esValidoForm: true );
  }

}


//! 1 - State del provider
class OlvidoContraseniaFormState {

  final bool esValidoForm;
  final Email email;
  GlobalKey<FormState> formKey;

  OlvidoContraseniaFormState({
    this.esValidoForm = false,
    this.email = const Email.pure(),
    required this.formKey,
  });

  OlvidoContraseniaFormState copyWith({
    bool? esValidoForm,
    Email? email,
    GlobalKey<FormState>? formKey
  }) => OlvidoContraseniaFormState(
    esValidoForm: esValidoForm ?? this.esValidoForm,
    email: email ?? this.email,
    formKey: formKey ?? this.formKey,
  );

}
