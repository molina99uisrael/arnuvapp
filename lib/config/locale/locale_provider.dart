import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/utils/arnuv_provider.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, LocalState>((ref) => LocaleNotifier());

class LocaleNotifier extends ArnuvNotifier<LocalState> {
  LocaleNotifier() : super(LocalState());

  void changeLocale(Locale locale) {
    state = state.copyWith(
      locale: locale
    );
  }
}

class LocalState extends ArnuvState {

  final Locale locale;

  LocalState({
    this.locale = const Locale('es'),
    super.errorMessage,
    super.succesMessage,
  });

  LocalState copyWith({
    Locale? locale
  }) => LocalState(
    locale: locale ?? this.locale,
  );

  LocalState limpiarState() => LocalState(
    locale: const Locale('es'),
    errorMessage: ""
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => LocalState(
    locale: locale,
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage
  );

}