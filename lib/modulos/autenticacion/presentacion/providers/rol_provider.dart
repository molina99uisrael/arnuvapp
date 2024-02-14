
import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/autenticacion/infraestructura/infrastructure.dart';
import 'package:arnuvapp/modulos/autenticacion/presentacion/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final rolProvider = StateNotifierProvider.autoDispose<RolNotifier,RolState>((ref) {

  final repository = RolRepositoryImpl();
  final metodoSegPolitica = ref.watch(segPoliticaDropdownProvider.notifier).getRegistroSeleccionado;
  final segpoliseleccionado = ref.watch(segPoliticaDropdownProvider.notifier).onSeleccionChange;

  return RolNotifier(
    rolRepository: repository,
    registroSeleccionadoCallback: metodoSegPolitica,
    segpolSelectCallback: segpoliseleccionado
  );
});


//! 2 - Como implementamos un notifier
class RolNotifier extends ArnuvNotifier<RolState> implements ArnuvCrud<Rol> {

  final RolRepository rolRepository;
  final Function() registroSeleccionadoCallback;
  final Function(String?) segpolSelectCallback;

  RolNotifier({
    required this.rolRepository,
    required this.registroSeleccionadoCallback,
    required this.segpolSelectCallback,
  }): super( RolState(registro: rolDefault.clone(), formKey: GlobalKey<FormState>()) ) {
    listar(1, 1);
  }

  @override
  listar(int limit, int page) async {
    try {
      final lista = await rolRepository.listar(limit, page);
      state = state.copyWith( lregistros: lista );
    } on AutenticacionException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  actualizar(Rol reg) async {
    try {
      var reg = registroSeleccionadoCallback();
      state = state.copyWith(registro: state.registro.copyWith(idpolitica: reg));
      await rolRepository.editar(state.registro);
      listar(1, 1);
    } on AutenticacionException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  guardar() async {
    try {
      var reg = registroSeleccionadoCallback();
      state = state.copyWith(registro: state.registro.copyWith(idpolitica: reg));
      var registro = await rolRepository.crear(state.registro);
      state.lregistros.add(registro);
      state = state.copyWith(lregistros: state.lregistros);
    } on AutenticacionException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  eliminar(Rol reg) {
    // print("METODO DE ELIMINAR PROVIDER ${reg.apellidos }");
  }
  
  @override
  limpiarRegistro() {
    state = state.copyWith(registro: rolDefault.clone(), esValidoForm: false);
  }
  
  @override
  seleccionaRegistro(Rol reg) {
    segpolSelectCallback(reg.idpolitica.id.toString());
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
class RolState extends ArnuvState {

  final List<Rol> lregistros;
  final Rol registro;
  final bool esValidoForm;
  GlobalKey<FormState> formKey;

  RolState({
    this.lregistros = const [],
    required this.registro,
    this.esValidoForm = false,
    required this.formKey,
    super.errorMessage,
    super.succesMessage,
  });

  RolState copyWith({
    List<Rol>? lregistros,
    Rol? registro,
    bool? esValidoForm,
    GlobalKey<FormState>? formKey
  }) => RolState(
    lregistros: lregistros ?? this.lregistros,
    registro: registro ?? this.registro,
    esValidoForm: esValidoForm ?? this.esValidoForm,
    formKey: formKey ?? this.formKey,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => RolState(
    formKey: formKey,
    registro: rolDefault.clone(),
    esValidoForm: esValidoForm,
    lregistros: lregistros,
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage,
  );

}
