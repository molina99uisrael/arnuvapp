import 'package:arnuvapp/modulos/autenticacion/domain/entities/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/autenticacion/autenticacion.dart';

import 'package:arnuvapp/modulos/shared/shared.dart';

class SideMenu extends ConsumerStatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;
  const SideMenu({
    super.key, 
    required this.scaffoldKey,
  });

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends ConsumerState<SideMenu> {

  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {

    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;
    final user = ref.watch(authProvider).user;
    final lmenu = ref.watch(authProvider).menu;

    return NavigationDrawer(
      elevation: 1,
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {

        setState(() {
          navDrawerIndex = value;
        });
        
        for (var menu in lmenu!) {
          for (var itemmenu in menu.items) {
            if (itemmenu.index == value) {
              ref.watch(authProvider.notifier).setOpcionMenu(itemmenu);
              context.push( itemmenu.ruta! );
              widget.scaffoldKey.currentState?.closeDrawer();
              break;
            }
          }
        }
        if (value == 0) {
          context.push( ConstRoutes.NAVEGACION );
        }
        widget.scaffoldKey.currentState?.closeDrawer();

      },
      children: [

        Padding(
          padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
          child: Text('Saludos', style: textStyles.titleMedium ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 16, 10),
          child: Text(user != null ? user.email : "", style: textStyles.titleSmall ),
        ),
        
        ...litemsmenu(lmenu),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BotonPrimario(
            icon: const Icon(Icons.logout, color: Colors.white),
            label: 'Cerrar sesión',
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            }
          ),
        ),

      ]
    );
  }

  List<Widget> litemsmenu(List<Menu>? lmenu) {
    List<Widget> lresulado = [
      const NavigationDrawerDestination(
        icon: Icon( Icons.home_outlined ), 
        label: Text( 'Home' ),
      ),
      const Padding(
        padding: EdgeInsets.fromLTRB(28, 1, 28, 1),
        child: Divider(),
      )
    ];
    if (lmenu == null ) {
      return lresulado;
    }
    for (var menuitem in lmenu) {
      lresulado.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 10, 16, 1),
          child: Text(menuitem.nombre),
        )
      );
      if (menuitem.items.isEmpty) {
        lresulado.add( const Padding(
          padding: EdgeInsets.fromLTRB(28, 1, 28, 1),
          child: Divider(),
        ));
        continue;
      }
      for (var element in menuitem.items) {
        lresulado.add(
          NavigationDrawerDestination(
            icon: const Icon( Icons.label_important_outline_sharp ), 
            label: Text( element.nombre! ),
          )
        );
      }
      lresulado.add( const Padding(
        padding: EdgeInsets.fromLTRB(28, 1, 28, 1),
        child: Divider(),
      ));
    }
    return lresulado;
  }
}