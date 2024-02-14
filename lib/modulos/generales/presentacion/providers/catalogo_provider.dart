
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/infraestructura/infraestructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final catalogProvider = StateNotifierProvider.autoDispose<CatalogoNotifier,CatalogoState>((ref) {

  final repository = CatalogoRepositoryImpl();

  return CatalogoNotifier(
    catalogoRepository: repository
  );
});


//! 2 - Como implementamos un notifier
class CatalogoNotifier extends ArnuvNotifier<CatalogoState> implements ArnuvCrud<Catalogo> {

  final CatalogoRepository catalogoRepository;

  CatalogoNotifier({
    required this.catalogoRepository,
  }): super( CatalogoState(registro: catalogoDefault.clone(), formKey: GlobalKey<FormState>()) ) {
    listar(1, 1);
  }

  @override
  listar(int limit, int page) async {
    try {
      final lista = await catalogoRepository.listar(limit, page);
      state = state.copyWith( lregistros: lista );
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  actualizar(Catalogo reg) async {
    try {
      await catalogoRepository.editar(state.registro);
      listar(1, 1);
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  guardar() async {
    try {
      var registro = await catalogoRepository.crear(state.registro);
      state.lregistros.add(registro);
      state = state.copyWith(lregistros: state.lregistros);
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  eliminar(Catalogo reg) {
    // print("METODO DE ELIMINAR PROVIDER ${reg.apellidos }");
  }
  
  @override
  limpiarRegistro() {
    state = state.copyWith(registro: catalogoDefault.clone(), esValidoForm: false);
  }
  
  @override
  seleccionaRegistro(Catalogo reg) {
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
class CatalogoState extends ArnuvState {

  final List<Catalogo> lregistros;
  final Catalogo registro;
  final bool esValidoForm;
  GlobalKey<FormState> formKey;

  CatalogoState({
    this.lregistros = const [],
    required this.registro,
    this.esValidoForm = false,
    required this.formKey,
    super.errorMessage,
    super.succesMessage
  });

  CatalogoState copyWith({
    List<Catalogo>? lregistros,
    Catalogo? registro,
    bool? esValidoForm,
    GlobalKey<FormState>? formKey
  }) => CatalogoState(
    lregistros: lregistros ?? this.lregistros,
    registro: registro ?? this.registro,
    esValidoForm: esValidoForm ?? this.esValidoForm,
    formKey: formKey ?? this.formKey,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => CatalogoState(
    formKey: formKey,
    registro: catalogoDefault.clone(),
    esValidoForm: esValidoForm,
    lregistros: lregistros,
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage
  );

}
