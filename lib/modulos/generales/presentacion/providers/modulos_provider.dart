
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/infraestructura/infraestructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final modulosProvider = StateNotifierProvider.autoDispose<ModulosNotifier,ModulosState>((ref) {

  final repository = ModulosRepositoryImpl();

  return ModulosNotifier(
    modulosRepository: repository
  );
});


//! 2 - Como implementamos un notifier
class ModulosNotifier extends ArnuvNotifier<ModulosState> implements ArnuvCrud<Modulos> {

  final ModulosRepository modulosRepository;

  ModulosNotifier({
    required this.modulosRepository,
  }): super( ModulosState(registro: modulosDefault.clone(), formKey: GlobalKey<FormState>()) ) {
    listar(1, 1);
  }

  @override
  listar(int limit, int page) async {
    try {
      final lista = await modulosRepository.listar(limit, page);
      state = state.copyWith( lregistros: lista );
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  actualizar(Modulos reg) async {
    try {
      await modulosRepository.editar(state.registro);
      listar(1, 1);
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  guardar() async {
    try {
      var registro = await modulosRepository.crear(state.registro);
      state.lregistros.add(registro);
      state = state.copyWith(lregistros: state.lregistros);
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  eliminar(Modulos reg) {
    // print("METODO DE ELIMINAR PROVIDER ${reg.apellidos }");
  }
  
  @override
  limpiarRegistro() {
    state = state.copyWith(registro: modulosDefault.clone(), esValidoForm: false);
  }
  
  @override
  seleccionaRegistro(Modulos reg) {
    state = state.copyWith(registro: reg, esValidoForm: false);
  }

  esFormularioValido() {
    state = state.copyWith( esValidoForm: false );
    if (state.formKey.currentState?.validate() != true) return;
    state = state.copyWith( esValidoForm: true );
  }

  setCheckActivo(bool? value) {
    state = state.copyWith(registro: state.registro.copyWith(activo: value!));
    esFormularioValido();
  }

}


//! 1 - State del provider
class ModulosState extends ArnuvState {

  final List<Modulos> lregistros;
  final Modulos registro;
  final bool esValidoForm;
  GlobalKey<FormState> formKey;

  ModulosState({
    this.lregistros = const [],
    required this.registro,
    this.esValidoForm = false,
    required this.formKey,
    super.errorMessage,
    super.succesMessage
  });

  ModulosState copyWith({
    List<Modulos>? lregistros,
    Modulos? registro,
    bool? esValidoForm,
    GlobalKey<FormState>? formKey
  }) => ModulosState(
    lregistros: lregistros ?? this.lregistros,
    registro: registro ?? this.registro,
    esValidoForm: esValidoForm ?? this.esValidoForm,
    formKey: formKey ?? this.formKey,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => ModulosState(
    formKey: formKey,
    registro: modulosDefault.clone(),
    esValidoForm: esValidoForm,
    lregistros: lregistros,
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage
  );

}
