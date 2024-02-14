
import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/autenticacion/infraestructura/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final segPoliticaDropdownProvider = StateNotifierProvider.autoDispose<SeguridadPoliticaDropdownNotifier,SeguridadPoliticaDropdownState>((ref) {

  final repository = SeguridadPoliticaRepositoryImpl();

  return SeguridadPoliticaDropdownNotifier(
    catalogoRepository: repository
  );
});


//! 2 - Como implementamos un notifier
class SeguridadPoliticaDropdownNotifier extends ArnuvNotifier<SeguridadPoliticaDropdownState> {

  final SeguridadPoliticaRepository catalogoRepository;

  SeguridadPoliticaDropdownNotifier({
    required this.catalogoRepository,
  }): super( SeguridadPoliticaDropdownState(lregistros: [seguridadPoliticaDefault.clone()], registroSelect: seguridadPoliticaDefault.clone() ) ){
    listar(1, 1);
  }

  listar(int limit, int page) async {
    try {
      final lista = await catalogoRepository.listar(limit, page);
      lista.insert(0, seguridadPoliticaDefault.clone());
      state = state.copyWith( lregistros: lista );
    } on AutenticacionException catch (e) {
      super.setMensajeError(e.message);
    }
  }

  onSeleccionChange(String? value) {
    if (value == null || value == "" || state.lregistros.length <= 1) return;

    state = state.copyWith(
      registroSelect: state.lregistros.firstWhere((o) => o.id.toString() == value),
    );
 
  }

  SeguridadPolitica getRegistroSeleccionado(){
    return state.registroSelect;
  }
  
}


//! 1 - State del provider
class SeguridadPoliticaDropdownState extends ArnuvState {

  final List<SeguridadPolitica> lregistros;
  final SeguridadPolitica registroSelect;

  SeguridadPoliticaDropdownState({
    required this.lregistros,
    required this.registroSelect,
    super.errorMessage,
    super.succesMessage
  });

  SeguridadPoliticaDropdownState copyWith({
    List<SeguridadPolitica>? lregistros,
    SeguridadPolitica? registroSelect,
  }) => SeguridadPoliticaDropdownState(
    lregistros: lregistros ?? this.lregistros,
    registroSelect: registroSelect ?? this.registroSelect,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => SeguridadPoliticaDropdownState(
    lregistros: [seguridadPoliticaDefault.clone()],
    registroSelect: seguridadPoliticaDefault.clone(),
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage
  );

}
