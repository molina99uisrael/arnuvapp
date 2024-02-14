import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//! 3 - StateNotifierProvider - consume afuera
final navegacionProvider = StateNotifierProvider.autoDispose<NavegacionNotifier,NavegacionState>((ref) {

  return NavegacionNotifier();
});


//! 2 - Como implementamos un notifier
class NavegacionNotifier extends StateNotifier<NavegacionState> {

  NavegacionNotifier(): super( NavegacionState() );

  void onSeleccionaMenu(int value) {
    state = state.copyWith(
      menuIndex: value
    );
  }

}


//! 1 - State del provider
class NavegacionState {

  final int menuIndex;
  List<BottomNavigationBarItem> items = [];

  NavegacionState({
    this.menuIndex = 0,
    this.items = const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        activeIcon: Icon(Icons.home_outlined),
        label: 'Home'
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        activeIcon: Icon(Icons.person_outline),
        label: 'Perfil'
      ),
    ]
  });

  NavegacionState copyWith({
    int? menuIndex,
    List<BottomNavigationBarItem>? items,
  }) => NavegacionState(
    menuIndex: menuIndex ?? this.menuIndex,
    items: items ?? this.items,
  );

}
