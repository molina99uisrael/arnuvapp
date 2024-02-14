import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/navegacion/presentacion/providers/providers.dart';
import 'package:arnuvapp/modulos/navegacion/presentacion/screens/screens.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

class NavegacionScreen extends StatelessWidget {
  const NavegacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: _NavegacionApp()
    );
  }
}

class _NavegacionApp extends ConsumerWidget {

  _NavegacionApp();

  final List<Widget> _children = [
    const HomeScreen(),
    const PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeStyle = Theme.of(context);
    final navegacion = ref.watch(navegacionProvider);
    final navegacionNotifier = ref.watch(navegacionProvider.notifier);
    
    final scaffoldKey = GlobalKey<ScaffoldState>();
    
    return Scaffold(
      drawer: SideMenu( scaffoldKey: scaffoldKey ),
      backgroundColor: themeStyle.primaryColor,
      appBar: AppBar(),
      body: _children[navegacion.menuIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 15,
        onTap: (index) => navegacionNotifier.onSeleccionaMenu(index),
        showUnselectedLabels: true,
        currentIndex: navegacion.menuIndex,
        items: navegacion.items,
      )
    );
  }
}