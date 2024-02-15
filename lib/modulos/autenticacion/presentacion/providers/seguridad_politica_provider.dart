
import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/autenticacion/infraestructura/infrastructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final seguridadPoliticaProvider = StateNotifierProvider.autoDispose<SeguridadPoliticaNotifier,SeguridadPoliticaState>((ref) {

  final repository = SeguridadPoliticaRepositoryImpl();

  return SeguridadPoliticaNotifier(
    seguridadPoliticaRepository: repository
  );
});


//! 2 - Como implementamos un notifier
class SeguridadPoliticaNotifier extends ArnuvNotifier<SeguridadPoliticaState> implements ArnuvCrud<SeguridadPolitica> {

  final SeguridadPoliticaRepository seguridadPoliticaRepository;

  SeguridadPoliticaNotifier({
    required this.seguridadPoliticaRepository,
  }): super( SeguridadPoliticaState(registro: seguridadPoliticaDefault.clone(), formKey: GlobalKey<FormState>()) ) {
    listar(1, 1);
  }

  @override
  listar(int limit, int page) async {
    try {
      final lista = await seguridadPoliticaRepository.listar(limit, page);
      state = state.copyWith( lregistros: lista );
    } on AutenticacionException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  actualizar(SeguridadPolitica reg) async {
    try {
      await seguridadPoliticaRepository.editar(state.registro);
      listar(1, 1);
    } on AutenticacionException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  guardar() async {
    try {
      var registro = await seguridadPoliticaRepository.crear(state.registro);
      state.lregistros.add(registro);
      state = state.copyWith(lregistros: state.lregistros);
    } on AutenticacionException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  eliminar(SeguridadPolitica reg) {
    // print("METODO DE ELIMINAR PROVIDER ${reg.apellidos }");
  }
  
  @override
  limpiarRegistro() {
    state = state.copyWith(registro: seguridadPoliticaDefault.clone(), esValidoForm: false);
  }
  
  @override
  seleccionaRegistro(SeguridadPolitica reg) {
    state = state.copyWith(registro: reg, esValidoForm: false);
  }

  esFormularioValido() {
    state = state.copyWith( esValidoForm: false );
    if (state.formKey.currentState?.validate() != true) return;
    state = state.copyWith( esValidoForm: true );
  }

}


//! 1 - State del provider
class SeguridadPoliticaState extends ArnuvState {

  final List<SeguridadPolitica> lregistros;
  final SeguridadPolitica registro;
  final bool esValidoForm;
  GlobalKey<FormState> formKey;

  SeguridadPoliticaState({
    this.lregistros = const [],
    required this.registro,
    this.esValidoForm = false,
    required this.formKey,
    super.errorMessage,
    super.succesMessage
  });

  SeguridadPoliticaState copyWith({
    List<SeguridadPolitica>? lregistros,
    SeguridadPolitica? registro,
    bool? esValidoForm,
    GlobalKey<FormState>? formKey
  }) => SeguridadPoliticaState(
    lregistros: lregistros ?? this.lregistros,
    registro: registro ?? this.registro,
    esValidoForm: esValidoForm ?? this.esValidoForm,
    formKey: formKey ?? this.formKey,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => SeguridadPoliticaState(
    formKey: formKey,
    registro: registro,
    esValidoForm: esValidoForm,
    lregistros: lregistros,
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage
  );

}
