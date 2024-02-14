
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/infraestructura/infraestructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final catalogoDetalleProvider = StateNotifierProvider.autoDispose<CatalogoDetalleNotifier,CatalogoDetalleState>((ref) {

  final repository = CatalogoDetalleRepositoryImpl();

  return CatalogoDetalleNotifier(
    catalogoDetalleRepository: repository
  );
});


//! 2 - Como implementamos un notifier
class CatalogoDetalleNotifier extends ArnuvNotifier<CatalogoDetalleState> implements ArnuvCrud<CatalogoDetalle> {

  final CatalogoDetalleRepository catalogoDetalleRepository;

  CatalogoDetalleNotifier({
    required this.catalogoDetalleRepository,
  }): super( CatalogoDetalleState(registro: catalogoDetalleDefault.clone(), formKey: GlobalKey<FormState>()) ) {
    // listar(1, 1);
  }

  @override
  listar(int limit, int page) async {
    try {
      final lista = await catalogoDetalleRepository.listar(limit, page);
      state = state.copyWith( lregistros: lista );
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  actualizar(CatalogoDetalle reg) async {
    try {
      await catalogoDetalleRepository.editar(state.registro);
      listarPorIdCatalogo(state.idcatalogo);
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  guardar() async {
    try {
      var registro = await catalogoDetalleRepository.crear(state.registro);
      state.lregistros.add(registro);
      state = state.copyWith(lregistros: state.lregistros);
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }
  
  @override
  eliminar(CatalogoDetalle reg) {
    // print("METODO DE ELIMINAR PROVIDER ${reg.apellidos }");
  }
  
  @override
  limpiarRegistro() {
    if (state.idcatalogo == 0) {
      state = state.copyWith(registro: catalogoDetalleDefault.clone(), esValidoForm: false);
    } else {
      catalogoDetalleDefault.id.idcatalogo = state.idcatalogo;
      catalogoDetalleDefault.id.iddetalle = "";
      state = state.copyWith(registro: catalogoDetalleDefault.clone(), esValidoForm: false);
    }
  }
  
  @override
  seleccionaRegistro(CatalogoDetalle reg) {
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

  listarPorIdCatalogo(int idcatalogo ) async {
    if (idcatalogo == 0) return;

    try {
      final lista = await catalogoDetalleRepository.listarByIdCatalogo(1,1, idcatalogo);
      state = state.copyWith( lregistros: lista, idcatalogo: idcatalogo );
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }

}


//! 1 - State del provider
class CatalogoDetalleState extends ArnuvState {

  final List<CatalogoDetalle> lregistros;
  final CatalogoDetalle registro;
  final int idcatalogo;
  final bool esValidoForm;
  GlobalKey<FormState> formKey;

  CatalogoDetalleState({
    this.lregistros = const [],
    required this.registro,
    this.idcatalogo = 0,
    this.esValidoForm = false,
    required this.formKey,
    super.errorMessage,
    super.succesMessage
  });

  CatalogoDetalleState copyWith({
    List<CatalogoDetalle>? lregistros,
    CatalogoDetalle? registro,
    int? idcatalogo,
    bool? esValidoForm,
    GlobalKey<FormState>? formKey
  }) => CatalogoDetalleState(
    lregistros: lregistros ?? this.lregistros,
    registro: registro ?? this.registro,
    idcatalogo: idcatalogo ?? this.idcatalogo,
    esValidoForm: esValidoForm ?? this.esValidoForm,
    formKey: formKey ?? this.formKey,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => CatalogoDetalleState(
    formKey: formKey,
    registro: catalogoDetalleDefault.clone(),
    esValidoForm: esValidoForm,
    idcatalogo: idcatalogo,
    lregistros: lregistros,
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage
  );

}
