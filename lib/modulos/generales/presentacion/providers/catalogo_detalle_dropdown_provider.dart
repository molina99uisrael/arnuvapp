
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/infraestructura/infraestructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final catalogoDetalleDropdownProvider = StateNotifierProvider.autoDispose<CatalogoDetalleDropdownNotifier,CatalogoDetalleDropdownState>((ref) {

  final repository = CatalogoDetalleRepositoryImpl();

  return CatalogoDetalleDropdownNotifier(
    catalogoDetalleRepository: repository
  );
});


//! 2 - Como implementamos un notifier
class CatalogoDetalleDropdownNotifier extends ArnuvNotifier<CatalogoDetalleDropdownState> {

  final CatalogoDetalleRepository catalogoDetalleRepository;

  CatalogoDetalleDropdownNotifier({
    required this.catalogoDetalleRepository,
  }): super( CatalogoDetalleDropdownState(lregistros: [catalogoDetalleDefault.clone()], registroSelect: catalogoDetalleDefault.clone() ) ){
    // listar(1, 1);
  }

  listarCatalogDetalle(int idcatalogo) async {
    try {
      final lista = await catalogoDetalleRepository.listarByIdCatalogo(100, 1, idcatalogo);
      lista.insert(0, catalogoDetalleDefault.clone());
      state = state.copyWith( lregistros: lista, idcatalogo: idcatalogo );
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }

  onSeleccionChange(String? value) {
    if (value == null || value == "" || state.lregistros.length <= 1) return;
    state = state.copyWith( 
      registroSelect: state.lregistros.firstWhere((o) => o.id.iddetalle.toString() == value) 
    );
  }
  
  CatalogoDetalle getRegistroSeleccionado(){
    return state.registroSelect;
  }
}


//! 1 - State del provider
class CatalogoDetalleDropdownState extends ArnuvState {

  final List<CatalogoDetalle> lregistros;
  final CatalogoDetalle registroSelect;
  final int idcatalogo;

  CatalogoDetalleDropdownState({
    required this.lregistros,
    required this.registroSelect,
    this.idcatalogo = 0,
    super.errorMessage,
    super.succesMessage,
  });

  CatalogoDetalleDropdownState copyWith({
    List<CatalogoDetalle>? lregistros,
    CatalogoDetalle? registroSelect,
    int? idcatalogo,
  }) => CatalogoDetalleDropdownState(
    lregistros: lregistros ?? this.lregistros,
    registroSelect: registroSelect ?? this.registroSelect,
    idcatalogo: idcatalogo ?? this.idcatalogo,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => CatalogoDetalleDropdownState(
    lregistros: [catalogoDetalleDefault.clone()],
    registroSelect: catalogoDetalleDefault.clone(),
    idcatalogo: idcatalogo,
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage
  );

}
