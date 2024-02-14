
import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/autenticacion/infraestructura/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final rolDropdownProvider = StateNotifierProvider.autoDispose<RolDropdownNotifier,RolDropdownState>((ref) {

  final repository = RolRepositoryImpl();

  return RolDropdownNotifier(
    rolRepository: repository
  );
});


//! 2 - Como implementamos un notifier
class RolDropdownNotifier extends ArnuvNotifier<RolDropdownState> {

  final RolRepository rolRepository;

  RolDropdownNotifier({
    required this.rolRepository,
  }): super( RolDropdownState(lregistros: [rolDefault.clone()], registroSelect: rolDefault.clone() ) ){
    listar(1, 1);
  }

  listar(int limit, int page) async {
    try {
      final lista = await rolRepository.listar(limit, page);
      lista.insert(0, rolDefault.clone());
      state = state.copyWith( lregistros: lista );
    } on AutenticacionException catch (e) {
      super.setMensajeError(e.message);
    }
  }

  onSeleccionChange(String? value) {
    if (value == null || value == "" || state.lregistros.length <= 1) return;
    state = state.copyWith( 
      registroSelect: state.lregistros.firstWhere((o) => o.id.toString() == value) 
    );
  }
  
  Rol getRegistroSeleccionado(){
    return state.registroSelect;
  }
}


//! 1 - State del provider
class RolDropdownState extends ArnuvState {

  final List<Rol> lregistros;
  final Rol registroSelect;
  final int idcatalogo;

  RolDropdownState({
    required this.lregistros,
    required this.registroSelect,
    this.idcatalogo = 0,
    super.errorMessage,
    super.succesMessage
  });

  RolDropdownState copyWith({
    List<Rol>? lregistros,
    Rol? registroSelect,
    int? idcatalogo,
  }) => RolDropdownState(
    lregistros: lregistros ?? this.lregistros,
    registroSelect: registroSelect ?? this.registroSelect,
    idcatalogo: idcatalogo ?? this.idcatalogo,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => RolDropdownState(
    lregistros: [rolDefault.clone()],
    registroSelect: rolDefault.clone(),
    idcatalogo: idcatalogo,
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage
  );

}
