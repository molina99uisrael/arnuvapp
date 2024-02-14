import 'package:arnuvapp/modulos/generales/presentacion/providers/catalogo_detalle_dropdown_provider.dart';
import 'package:arnuvapp/modulos/personas/domain/domain.dart';
import 'package:arnuvapp/modulos/personas/infraestructura/infraestructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final personaDetalleProvider = StateNotifierProvider.autoDispose<PersonaDetalleNotifier,PersonaDetalleState>((ref) {

  final personaDetalleRep = PersonaDetalleRepositoryImpl();
  final metodoCatalogoDetalle = ref.watch(catalogoDetalleDropdownProvider.notifier).getRegistroSeleccionado;
  final catdellseleccionado = ref.watch(catalogoDetalleDropdownProvider.notifier).onSeleccionChange;

  return PersonaDetalleNotifier(
    personaDetalleRepository: personaDetalleRep,
    registroSeleccionadoCallback: metodoCatalogoDetalle,
    catdelSelectCallback: catdellseleccionado
  );
});


//! 2 - Como implementamos un notifier
class PersonaDetalleNotifier extends ArnuvNotifier<PersonaDetalleState> implements ArnuvCrud<PersonaDetalle> {

  final PersonaDetalleRepository personaDetalleRepository;
  final Function() registroSeleccionadoCallback;
  final Function(String?) catdelSelectCallback;

  PersonaDetalleNotifier({
    required this.personaDetalleRepository,
    required this.registroSeleccionadoCallback,
    required this.catdelSelectCallback,
  }): super( PersonaDetalleState(registro: personaDetalleDefault.clone(), formKey: GlobalKey<FormState>()) ) {
    listar(1, 1);
  }

  @override
  listar(int limit, int page) async {
    try {
      final lista = await personaDetalleRepository.listar(limit, page);
      state = state.copyWith(
        lregistros: lista
      );
    } on PersonaException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  actualizar(PersonaDetalle reg) async {
    try {
      var reg = registroSeleccionadoCallback();
      state = state.copyWith(registro: state.registro.copyWith(catalogodetalle: reg));
      await personaDetalleRepository.editar(state.registro);
      listar(1, 1);
    } on PersonaException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  guardar() async {
    try {
      var reg = registroSeleccionadoCallback();
      state = state.copyWith(registro: state.registro.copyWith(catalogodetalle: reg));
      var registro = await personaDetalleRepository.crear(state.registro);
      state.lregistros.add(registro);
      state = state.copyWith(lregistros: state.lregistros);
    } on PersonaException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  eliminar(PersonaDetalle reg) {
    // print("METODO DE ELIMINAR PROVIDER ${reg.apellidos }");
  }
  
  @override
  limpiarRegistro() {
    state = state.copyWith(registro: personaDetalleDefault.clone(), esValidoForm: false);
  }
  
  @override
  seleccionaRegistro(PersonaDetalle reg) {
    catdelSelectCallback(reg.catalogodetalle.id.iddetalle);
    state = state.copyWith(registro: reg, esValidoForm: false);
  }

  esFormularioValido() {
    state = state.copyWith( esValidoForm: false );
    if (state.formKey.currentState?.validate() != true) return;
    state = state.copyWith( esValidoForm: true );
  }

  Future<PersonaDetalle> buscarPorIdentificacion(String identificacion) async {
    try {
      return await personaDetalleRepository.buscarPorIdentificacion(identificacion);
    } on PersonaException catch (e) {
      super.setMensajeError(e.message);
    }
    return personaDetalleDefault.clone();
  }

}


//! 1 - State del provider
class PersonaDetalleState extends ArnuvState {

  final List<PersonaDetalle> lregistros;
  final PersonaDetalle registro;
  final bool esValidoForm;
  GlobalKey<FormState> formKey;

  PersonaDetalleState({
    this.lregistros = const [],
    required this.registro,
    this.esValidoForm = false,
    required this.formKey,
    super.errorMessage,
    super.succesMessage
  });

  PersonaDetalleState copyWith({
    List<PersonaDetalle>? lregistros,
    PersonaDetalle? registro,
    bool? esValidoForm,
    GlobalKey<FormState>? formKey
  }) => PersonaDetalleState(
    lregistros: lregistros ?? this.lregistros,
    registro: registro ?? this.registro,
    esValidoForm: esValidoForm ?? this.esValidoForm,
    formKey: formKey ?? this.formKey,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => PersonaDetalleState(
    formKey: formKey,
    registro: personaDetalleDefault.clone(),
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage,
    esValidoForm: esValidoForm,
    lregistros: lregistros
  );

}
