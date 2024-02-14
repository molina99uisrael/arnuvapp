
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/infraestructura/infraestructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final modulosDropdownProvider = StateNotifierProvider.autoDispose<ModulosDropdownNotifier,ModulosDropdownState>((ref) {

  final repository = ModulosRepositoryImpl();

  return ModulosDropdownNotifier(
    modulosRepository: repository
  );
});


//! 2 - Como implementamos un notifier
class ModulosDropdownNotifier extends ArnuvNotifier<ModulosDropdownState> {

  final ModulosRepository modulosRepository;

  ModulosDropdownNotifier({
    required this.modulosRepository,
  }): super( ModulosDropdownState(lregistros: [modulosDefault.clone()], registroSelect: modulosDefault.clone() ) ){
    listar(1, 1);
  }

  listar(int limit, int page) async {
    try {
      final lista = await modulosRepository.listar(limit, page);
      lista.insert(0, modulosDefault.clone());
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
class ModulosDropdownState extends ArnuvState {

  final List<Modulos> lregistros;
  final Modulos registroSelect;

  ModulosDropdownState({
    required this.lregistros,
    required this.registroSelect,
    super.errorMessage,
    super.succesMessage
  });

  ModulosDropdownState copyWith({
    List<Modulos>? lregistros,
    Modulos? registroSelect,
  }) => ModulosDropdownState(
    lregistros: lregistros ?? this.lregistros,
    registroSelect: registroSelect ?? this.registroSelect,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => ModulosDropdownState(
    lregistros: [modulosDefault.clone()],
    registroSelect: modulosDefault.clone(),
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage
  );

}
