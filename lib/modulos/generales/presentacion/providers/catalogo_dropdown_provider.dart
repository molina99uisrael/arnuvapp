
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/infraestructura/infraestructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final catalogoDropdownProvider = StateNotifierProvider.autoDispose<CatalogoDropdownNotifier,CatalogoDropdownState>((ref) {

  final repository = CatalogoRepositoryImpl();

  return CatalogoDropdownNotifier(
    catalogoRepository: repository
  );
});


//! 2 - Como implementamos un notifier
class CatalogoDropdownNotifier extends ArnuvNotifier<CatalogoDropdownState> {

  final CatalogoRepository catalogoRepository;

  CatalogoDropdownNotifier({
    required this.catalogoRepository,
  }): super( CatalogoDropdownState(lregistros: [catalogoDefault.clone()], registroSelect: catalogoDefault.clone() ) ){
    listar(1, 1);
  }

  listar(int limit, int page) async {
    try {
      final lista = await catalogoRepository.listar(limit, page);
      lista.insert(0, catalogoDefault.clone());
      state = state.copyWith( lregistros: lista );
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }

  onSeleccionChange(String? value) {
    if (value == null || value =="") return;

    state = state.copyWith(
      registroSelect: state.lregistros.firstWhere((o) => o.id.toString() == value),
    );
 
  }
  
}


//! 1 - State del provider
class CatalogoDropdownState extends ArnuvState {

  final List<Catalogo> lregistros;
  final Catalogo registroSelect;

  CatalogoDropdownState({
    required this.lregistros,
    required this.registroSelect,
    super.errorMessage,
    super.succesMessage
  });

  CatalogoDropdownState copyWith({
    List<Catalogo>? lregistros,
    Catalogo? registroSelect,
  }) => CatalogoDropdownState(
    lregistros: lregistros ?? this.lregistros,
    registroSelect: registroSelect ?? this.registroSelect,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => CatalogoDropdownState(
    lregistros: [catalogoDefault.clone()],
    registroSelect: catalogoDefault.clone(),
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage
  );

}
