
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/infraestructura/infraestructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final recursosDropdownProvider = StateNotifierProvider.autoDispose<RecursosDropdownNotifier,RecursosDropdownState>((ref) {

  final repository = RecursosRepositoryImpl();

  return RecursosDropdownNotifier(
    recursosRepository: repository
  );
});


//! 2 - Como implementamos un notifier
class RecursosDropdownNotifier extends ArnuvNotifier<RecursosDropdownState> {

  final RecursosRepository recursosRepository;

  RecursosDropdownNotifier({
    required this.recursosRepository,
  }): super( RecursosDropdownState(lregistros: [recursoDefault.clone()], registroSelect: recursoDefault.clone() ) ){
    listarRecursos();
  }

  listarRecursos() async {
    try {
      final lista = await recursosRepository.listar(1,1);
      lista.insert(0, recursoDefault.clone());
      state = state.copyWith( lregistros: lista);
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }

  onSeleccionChange(String? value) {
    if (value == null || value == "" || state.lregistros.length <= 1) return;
    state = state.copyWith( 
      registroSelect: state.lregistros.firstWhere((o) => o.id.toString() == value) 
    );
  }
  
  Recursos getRegistroSeleccionado(){
    return state.registroSelect;
  }
}


//! 1 - State del provider
class RecursosDropdownState extends ArnuvState {

  final List<Recursos> lregistros;
  final Recursos registroSelect;
  final int idcatalogo;

  RecursosDropdownState({
    required this.lregistros,
    required this.registroSelect,
    this.idcatalogo = 0,
    super.errorMessage,
    super.succesMessage
  });

  RecursosDropdownState copyWith({
    List<Recursos>? lregistros,
    Recursos? registroSelect,
    int? idcatalogo,
  }) => RecursosDropdownState(
    lregistros: lregistros ?? this.lregistros,
    registroSelect: registroSelect ?? this.registroSelect,
    idcatalogo: idcatalogo ?? this.idcatalogo,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => RecursosDropdownState(
    lregistros: [recursoDefault.clone()],
    registroSelect: recursoDefault.clone(),
    idcatalogo: idcatalogo,
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage
  );

}
