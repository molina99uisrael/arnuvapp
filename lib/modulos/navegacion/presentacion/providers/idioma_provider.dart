import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/config/locale/locale_provider.dart';
import 'package:arnuvapp/modulos/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:arnuvapp/modulos/shared/infrastructure/services/key_value_storage_service_impl.dart';
import 'package:arnuvapp/modulos/shared/utils/arnuv_provider.dart';


final idiomaProvider = StateNotifierProvider<IdiomaNotifier,IdiomaState>((ref) {

  final keyValueStorageService = KeyValueStorageServiceImpl();
  final local = ref.watch(localeProvider.notifier);

  return IdiomaNotifier(
    keyValueStorageService: keyValueStorageService,
    local: local
  );
});



class IdiomaNotifier extends ArnuvNotifier<IdiomaState>  {

  final KeyValueStorageService keyValueStorageService;
  final LocaleNotifier local;

  IdiomaNotifier({
    required this.keyValueStorageService,
    required this.local,
  }): super( IdiomaState() );  

  

  void seleccionarLocale(String value) {
    state = state.copyWith(
      seleccionLocal: value
    );
    local.changeLocale(Locale(value));
  }

  setIdiomaAplicacion(String langCode, bool save) async {
    if (save) {
      await keyValueStorageService.setKeyValue<String>('currentLanguageKey',langCode);
    }
    seleccionarLocale(langCode);
  }

}


class IdiomaState extends ArnuvState {

  final String seleccionLocal;

  IdiomaState({
    this.seleccionLocal = '',
    super.errorMessage,
    super.succesMessage
  });

  IdiomaState copyWith({
    String? seleccionLocal,
  }) => IdiomaState(
    seleccionLocal: seleccionLocal ?? this.seleccionLocal,
  );

  IdiomaState limpiarState() => IdiomaState(
    seleccionLocal: "",
    errorMessage: ""
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => IdiomaState(
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage,
    seleccionLocal: seleccionLocal
  );

}