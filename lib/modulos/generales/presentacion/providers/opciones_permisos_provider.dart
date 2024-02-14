
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/presentacion/providers/recursos_dropdown_provider.dart';
import 'package:arnuvapp/modulos/generales/infraestructura/infraestructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final opcionesPermisosProvider = StateNotifierProvider.autoDispose<OpcionesPermisosNotifier,OpcionesPermisosState>((ref) {

  final repository = OpcionesPermisosRepositoryImpl();
  final metodoDropRecursos = ref.watch(recursosDropdownProvider.notifier).getRegistroSeleccionado;
  // final segpoliseleccionado = ref.watch(segPoliticaDropdownProvider.notifier).onSeleccionChange;

  return OpcionesPermisosNotifier(
    opcionesPermisosRepository: repository,
    registroSeleccionadoCallback: metodoDropRecursos
  );
});


//! 2 - Como implementamos un notifier
class OpcionesPermisosNotifier extends ArnuvNotifier<OpcionesPermisosState> implements ArnuvCrud<OpcionesPermisos> {

  final OpcionesPermisosRepository opcionesPermisosRepository;
  final Function() registroSeleccionadoCallback;

  OpcionesPermisosNotifier({
    required this.opcionesPermisosRepository,
    required this.registroSeleccionadoCallback
  }): super( OpcionesPermisosState(registro: opcionesPermisosDefault.clone(), formKey: GlobalKey<FormState>()) ) {
    // listar(1, 1);
  }

  @override
  listar(int limit, int page) async {
    try {
      final lista = await opcionesPermisosRepository.listar(limit, page);
      state = state.copyWith( lregistros: lista );
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  actualizar(OpcionesPermisos reg) async {
    try {
      var reg = registroSeleccionadoCallback();
      state = state.copyWith(registro: state.registro.copyWith(recursos: reg));
      await opcionesPermisosRepository.editar(state.registro);
      listarPorIdRol(state.idrol);
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  guardar() async {
    try {
      var reg = registroSeleccionadoCallback();
      state = state.copyWith(registro: state.registro.copyWith(recursos: reg));
      var registro = await opcionesPermisosRepository.crear(state.registro);
      state.lregistros.add(registro);
      state = state.copyWith(lregistros: state.lregistros);
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  eliminar(OpcionesPermisos reg) {
    // print("METODO DE ELIMINAR PROVIDER ${reg.apellidos }");
  }
  
  @override
  limpiarRegistro() {
    state = state.copyWith(registro: opcionesPermisosDefault.clone().copyWith(id: opcionesPermisosDefault.clone().id.copyWith(idrol: state.idrol)), esValidoForm: false);
  }
  
  @override
  seleccionaRegistro(OpcionesPermisos reg) {
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

  setCheckMostrar(bool? value) {
    state = state.copyWith(registro: state.registro.copyWith(mostar: value!));
    esFormularioValido();
  }

  setCheckCrear(bool? value) {
    state = state.copyWith(registro: state.registro.copyWith(crear: value!));
    esFormularioValido();
  }

  setCheckEditar(bool? value) {
    state = state.copyWith(registro: state.registro.copyWith(editar: value!));
    esFormularioValido();
  }

  setCheckEliminar(bool? value) {
    state = state.copyWith(registro: state.registro.copyWith(eliminar: value!));
    esFormularioValido();
  }

  listarPorIdRol(int idrol ) async {
    if (idrol == 0) return;

    try {
      final lista = await opcionesPermisosRepository.listarByIdRol(idrol);
      state = state.copyWith( lregistros: lista, idrol: idrol );
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }

}


//! 1 - State del provider
class OpcionesPermisosState extends ArnuvState {

  final List<OpcionesPermisos> lregistros;
  final OpcionesPermisos registro;
  final int idrol;
  final bool esValidoForm;
  GlobalKey<FormState> formKey;

  OpcionesPermisosState({
    this.lregistros = const [],
    required this.registro,
    this.idrol = 0,
    this.esValidoForm = false,
    required this.formKey,
    super.errorMessage,
    super.succesMessage
  });

  OpcionesPermisosState copyWith({
    List<OpcionesPermisos>? lregistros,
    OpcionesPermisos? registro,
    int? idrol,
    bool? esValidoForm,
    GlobalKey<FormState>? formKey
  }) => OpcionesPermisosState(
    lregistros: lregistros ?? this.lregistros,
    registro: registro ?? this.registro,
    idrol: idrol ?? this.idrol,
    esValidoForm: esValidoForm ?? this.esValidoForm,
    formKey: formKey ?? this.formKey,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => OpcionesPermisosState(
    formKey: formKey,
    registro: opcionesPermisosDefault.clone(),
    esValidoForm: esValidoForm,
    idrol: idrol,
    lregistros: lregistros,
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage
  );

}
