
import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/autenticacion/infraestructura/infrastructure.dart';
import 'package:arnuvapp/modulos/autenticacion/presentacion/providers/providers.dart';
import 'package:arnuvapp/modulos/personas/domain/entities/usuario_detalle_response.dart';
import 'package:arnuvapp/modulos/personas/presentacion/providers/usuario_detalle_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final usuarioRolProvider = StateNotifierProvider.autoDispose<UsuarioRolNotifier,UsuarioRolState>((ref) {

  final repository = UsuarioRolRepositoryImpl();
  final metodoRol = ref.watch(rolDropdownProvider.notifier).getRegistroSeleccionado;
  final rolseleccionado = ref.watch(segPoliticaDropdownProvider.notifier).onSeleccionChange;
  final buscarUsernameCallback = ref.watch(usuarioDetalleProvider.notifier).buscarPorEmail;

  return UsuarioRolNotifier(
    usuarioRolRepository: repository,
    registroSeleccionadoCallback: metodoRol,
    rolSelectCallback: rolseleccionado,
    buscarUsernameCallback: buscarUsernameCallback
  );
});


//! 2 - Como implementamos un notifier
class UsuarioRolNotifier extends ArnuvNotifier<UsuarioRolState> implements ArnuvCrud<UsuarioRol> {

  final UsuarioRolRepository usuarioRolRepository;
  final Function() registroSeleccionadoCallback;
  final Function(String?) rolSelectCallback;
  final Future<UsuarioDetalle> Function(String) buscarUsernameCallback;

  UsuarioRolNotifier({
    required this.usuarioRolRepository,
    required this.registroSeleccionadoCallback,
    required this.rolSelectCallback,
    required this.buscarUsernameCallback,
  }): super( UsuarioRolState(registro: usuarioRolDefault.clone(), formKey: GlobalKey<FormState>()) ) {
    // listar(1, 1);
  }

  listarPorRol(int limit, int page, int idrol) async {
    try {
      rolSelectCallback(idrol.toString());
      final lista = await usuarioRolRepository.listarPorRol(limit, page, idrol);
      state = state.copyWith( lregistros: lista );
    } on AutenticacionException catch (e) {
      super.setMensajeError(e.message);
    }
  }

  @override
  listar(int limit, int page) async {
    try {
      final lista = await usuarioRolRepository.listar(limit, page);
      state = state.copyWith( lregistros: lista );
    } on AutenticacionException catch (e) {
      super.setMensajeError(e.message);
    }
  }  
  
  @override
  actualizar(UsuarioRol reg) async {
    try {
      var reg = registroSeleccionadoCallback();
      state = state.copyWith(registro: state.registro.copyWith(idrol: reg));
      await usuarioRolRepository.editar(state.registro);
      listar(1, 1);
    } on AutenticacionException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  guardar() async {
    try {
      var reg = registroSeleccionadoCallback();
      state = state.copyWith(registro: state.registro.copyWith(idrol: reg));
      var registro = await usuarioRolRepository.crear(state.registro);
      state.lregistros.add(registro);
      state = state.copyWith(lregistros: state.lregistros);
    } on AutenticacionException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  eliminar(UsuarioRol reg) {
    // print("METODO DE ELIMINAR PROVIDER ${reg.apellidos }");
  }
  
  @override
  limpiarRegistro() {
    state = state.copyWith(registro: usuarioRolDefault.clone(), esValidoForm: false);
  }
  
  @override
  seleccionaRegistro(UsuarioRol reg) {
    rolSelectCallback(reg.idrol.id.toString());
    state = state.copyWith(registro: reg, esValidoForm: false);
  }

  esFormularioValido() {
    state = state.copyWith( esValidoForm: false );
    if (state.formKey.currentState?.validate() != true) return;
    state = state.copyWith( esValidoForm: true );
  }

  validarEmail(String value) async {
    var usuarioDetalle = await buscarUsernameCallback(value);
    if (usuarioDetalle.idusuario == 0) {
      super.setMensajeError("USERNAME NO VALIDO");
      return;
    } 
    state = state.copyWith(registro: state.registro.copyWith(idusuario: usuarioDetalle));
  }

}


//! 1 - State del provider
class UsuarioRolState extends ArnuvState {

  final List<UsuarioRol> lregistros;
  final UsuarioRol registro;
  final bool esValidoForm;
  GlobalKey<FormState> formKey;

  UsuarioRolState({
    this.lregistros = const [],
    required this.registro,
    this.esValidoForm = false,
    required this.formKey,
    super.errorMessage,
    super.succesMessage
  });

  UsuarioRolState copyWith({
    List<UsuarioRol>? lregistros,
    UsuarioRol? registro,
    bool? esValidoForm,
    GlobalKey<FormState>? formKey
  }) => UsuarioRolState(
    lregistros: lregistros ?? this.lregistros,
    registro: registro ?? this.registro,
    esValidoForm: esValidoForm ?? this.esValidoForm,
    formKey: formKey ?? this.formKey,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => UsuarioRolState(
    formKey: formKey,
    registro: usuarioRolDefault.clone(),
    lregistros: lregistros,
    esValidoForm: esValidoForm,
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage
  );

}

