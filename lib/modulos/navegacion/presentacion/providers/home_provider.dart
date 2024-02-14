import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/navegacion/domain/domain.dart';

//! 3 - StateNotifierProvider - consume afuera
final homeProvider = StateNotifierProvider.autoDispose<HomeNotifier,HomeState>((ref) {
  
  return HomeNotifier();
});


//! 2 - Como implementamos un notifier
class HomeNotifier extends StateNotifier<HomeState> {

  HomeNotifier(): super( HomeState() );
  
  onPushItem(List<ItemsOperaciones> opciones) {
    state.opciones =opciones;
  }
}


//! 1 - State del provider
class HomeState {

  List<ItemsOperaciones> opciones;

  HomeState({
    this.opciones = const[]
  });

  HomeState copyWith({
    List<ItemsOperaciones>? opciones,
  }) => HomeState(
    opciones: opciones ?? this.opciones,
  );

}
