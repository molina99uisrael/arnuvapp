import 'package:arnuvapp/modulos/personas/domain/domain.dart';
import 'package:arnuvapp/modulos/personas/infraestructura/infraestructure.dart';
import 'package:arnuvapp/modulos/personas/presentacion/providers/persona_detalle_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final usuarioDetalleProvider = StateNotifierProvider.autoDispose<UsuarioDetalleNotifier,UsuarioDetalleState>((ref) {

  final repository = UsuarioDetalleRepositoryImpl();
  final buscarIdentificacionCallback = ref.watch(personaDetalleProvider.notifier).buscarPorIdentificacion;

  return UsuarioDetalleNotifier(
    usuarioRepository: repository,
    buscarIdentificacionCallback: buscarIdentificacionCallback
  );
});


//! 2 - Como implementamos un notifier
class UsuarioDetalleNotifier extends ArnuvNotifier<UsuarioDetalleState> implements ArnuvCrud<UsuarioDetalle> {

  final UsuarioDetalleRepository usuarioRepository;
  final Future<PersonaDetalle> Function(String) buscarIdentificacionCallback;

  UsuarioDetalleNotifier({
    required this.usuarioRepository,
    required this.buscarIdentificacionCallback,
  }): super( UsuarioDetalleState(registro: usuarioDetalleDefault.clone(), formKey: GlobalKey<FormState>()) ) {
    listar(1, 1);  
  }

  Future<UsuarioDetalle> buscarPorEmail(String email) async {
    try {
      return await usuarioRepository.buscarPorEmail(email);
    } on PersonaException catch (e) {
      super.setMensajeError(e.message);
    }
    return usuarioDetalleDefault.clone();
  }

  @override
  listar(int limit, int page) async {
    try {
      final lista = await usuarioRepository.listar(limit, page);
      state = state.copyWith(
        lregistros: lista
      );
    } on PersonaException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  actualizar(UsuarioDetalle reg) async {
    try {
      
      await usuarioRepository.editar(state.registro);
      listar(1, 1);
    } on PersonaException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  guardar() async {
    try {
      state = state.copyWith(registro: state.registro.copyWith(password: ArnuvUtils.hashSHA256(state.registro.password)));
      var registro = await usuarioRepository.crear(state.registro);
      state.lregistros.add(registro);
      state = state.copyWith(lregistros: state.lregistros);
    } on PersonaException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  eliminar(UsuarioDetalle reg) {
    // print("METODO DE ELIMINAR PROVIDER ${reg.apellidos }");
  }
  
  @override
  limpiarRegistro() {
    state = state.copyWith(registro: usuarioDetalleDefault.clone(), esValidoForm: false);
  }
  
  @override
  seleccionaRegistro(UsuarioDetalle reg) {
    state = state.copyWith(registro: reg.copyWith(), esValidoForm: false);
  }

  esFormularioValido() {
    state = state.copyWith( esValidoForm: false );
    if (state.formKey.currentState?.validate() != true) return;
    state = state.copyWith( esValidoForm: true );
  }

  setCheckActivo(bool? value) {
    state = state.copyWith(registro: state.registro.copyWith(estado: value!));
    esFormularioValido();
  }

  validarIdentificacion(String identificacion) async {
     var personaDetalle = await buscarIdentificacionCallback(identificacion);
      if (personaDetalle.id == 0) {
        super.setMensajeError("PERSONA NO VALIDA");
        return;
      } 
      state = state.copyWith(registro: state.registro.copyWith(idpersona: personaDetalle));
  }

}


//! 1 - State del provider
class UsuarioDetalleState extends ArnuvState {

  final List<UsuarioDetalle> lregistros;
  final UsuarioDetalle registro;
  final bool esValidoForm;
  GlobalKey<FormState> formKey;

  UsuarioDetalleState({
    this.lregistros = const [],
    required this.registro,
    this.esValidoForm = false,
    required this.formKey,
    super.errorMessage,
    super.succesMessage
  });

  UsuarioDetalleState copyWith({
    List<UsuarioDetalle>? lregistros,
    UsuarioDetalle? registro,
    bool? esValidoForm,
    GlobalKey<FormState>? formKey
  }) => UsuarioDetalleState(
    lregistros: lregistros ?? this.lregistros,
    registro: registro ?? this.registro,
    esValidoForm: esValidoForm ?? this.esValidoForm,
    formKey: formKey ?? this.formKey,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => UsuarioDetalleState(
    formKey: formKey,
    registro: registro,
    esValidoForm: esValidoForm,
    lregistros: lregistros,
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage
  );

}
