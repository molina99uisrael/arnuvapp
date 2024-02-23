
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/infraestructura/infraestructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final titulosMenuDropdownProvider = StateNotifierProvider.autoDispose<TitulosMenuDropdownNotifier,TitulosMenuDropdownState>((ref) {

  final repository = OpcionesPermisosRepositoryImpl();

  return TitulosMenuDropdownNotifier(
    opcionesPermisosRepository: repository
  );
});


//! 2 - Como implementamos un notifier
class TitulosMenuDropdownNotifier extends ArnuvNotifier<TitulosMenuDropdownState> {

  final OpcionesPermisosRepository opcionesPermisosRepository;

  TitulosMenuDropdownNotifier({
    required this.opcionesPermisosRepository,
  }): super( TitulosMenuDropdownState(lregistros: [opcionesPermisosDefault.clone()], registroSelect: opcionesPermisosDefault.clone() ) );

  listarTitulosMenu(int idrol) async {
    try {
      final lista = await opcionesPermisosRepository.listarTitulosMenu(idrol);
      lista.insert(0, opcionesPermisosDefault.clone());
      state = state.copyWith( lregistros: lista );
    } on GeneralesException catch (e) {
      super.setMensajeError(e.message);
    }
  }

  onSeleccionChange(String? value) {
    if (value == null || value =="") return;

    state = state.copyWith(
      registroSelect: state.lregistros.firstWhere((o) => o.id.idopcion.toString() == value),
    ); 
  }

  OpcionesPermisos getRegistroSeleccionado(){
    return state.registroSelect;
  }
  
}


//! 1 - State del provider
class TitulosMenuDropdownState extends ArnuvState {

  final List<OpcionesPermisos> lregistros;
  final OpcionesPermisos registroSelect;
  final int idrol;

  TitulosMenuDropdownState({
    required this.lregistros,
    required this.registroSelect,
    this.idrol = 0,
    super.errorMessage,
    super.succesMessage
  });

  TitulosMenuDropdownState copyWith({
    List<OpcionesPermisos>? lregistros,
    OpcionesPermisos? registroSelect,
    int? idrol,
  }) => TitulosMenuDropdownState(
    lregistros: lregistros ?? this.lregistros,
    registroSelect: registroSelect ?? this.registroSelect,
    idrol: idrol ?? this.idrol,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => TitulosMenuDropdownState(
    lregistros: [opcionesPermisosDefault.clone()],
    registroSelect: opcionesPermisosDefault.clone(),
    idrol: idrol,
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage
  );

}
