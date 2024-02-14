
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/infraestructura/infraestructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final recursosProvider = StateNotifierProvider.autoDispose<RecursosNotifier,RecursosState>((ref) {

  final repository = RecursosRepositoryImpl();

  return RecursosNotifier(
    recursosRepository: repository
  );
});


//! 2 - Como implementamos un notifier
class RecursosNotifier extends ArnuvNotifier<RecursosState> implements ArnuvCrud<Recursos> {

  final RecursosRepository recursosRepository;

  RecursosNotifier({
    required this.recursosRepository,
  }): super( RecursosState(registro: recursoDefault.clone(), formKey: GlobalKey<FormState>()) ) {
    // listar(1, 1);
  }

  @override
  listar(int limit, int page) async {
    try {
      final lista = await recursosRepository.listar(limit, page);
      state = state.copyWith( lregistros: lista );
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  actualizar(Recursos reg) async {
    try {
      await recursosRepository.editar(state.registro);
      listarPorIdModulo(state.idmodulo);
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  guardar() async {
    try {
      var registro = await recursosRepository.crear(state.registro);
      state.lregistros.add(registro);
      state = state.copyWith(lregistros: state.lregistros);
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  eliminar(Recursos reg) {
    // print("METODO DE ELIMINAR PROVIDER ${reg.apellidos }");
  }
  
  @override
  limpiarRegistro() {
    state = state.copyWith(registro: recursoDefault.clone().copyWith(id: recursoDefault.clone().id.copyWith(idmodulo: state.idmodulo)), esValidoForm: false);
  }
  
  @override
  seleccionaRegistro(Recursos reg) {
    state = state.copyWith(registro: reg, esValidoForm: false);
  }

  esFormularioValido() {
    state = state.copyWith( esValidoForm: false );
    if (state.formKey.currentState?.validate() != true) return;
    state = state.copyWith( esValidoForm: true );
  }

  listarPorIdModulo(int idmodulo ) async {
    if (idmodulo == 0) return;

    try {
      final lista = await recursosRepository.listarByIdModulo(1,1, idmodulo);
      state = state.copyWith( lregistros: lista, idmodulo: idmodulo );
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }

}


//! 1 - State del provider
class RecursosState extends ArnuvState {

  final List<Recursos> lregistros;
  final Recursos registro;
  final bool esValidoForm;
  final int idmodulo;
  GlobalKey<FormState> formKey;

  RecursosState({
    this.lregistros = const [],
    required this.registro,
    this.esValidoForm = false,
    this.idmodulo = 0,
    required this.formKey,
    super.errorMessage,
    super.succesMessage
  });

  RecursosState copyWith({
    List<Recursos>? lregistros,
    Recursos? registro,
    bool? esValidoForm,
    int? idmodulo,
    GlobalKey<FormState>? formKey
  }) => RecursosState(
    lregistros: lregistros ?? this.lregistros,
    registro: registro ?? this.registro,
    idmodulo: idmodulo ?? this.idmodulo,
    esValidoForm: esValidoForm ?? this.esValidoForm,
    formKey: formKey ?? this.formKey,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => RecursosState(
    formKey: formKey,
    registro: recursoDefault.clone(),
    esValidoForm: esValidoForm,
    lregistros: lregistros,
    idmodulo: idmodulo,
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage
  );

}
