import 'package:arnuvapp/modulos/shared/presentacion/pagana_construccion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:arnuvapp/config/router/const_routes.dart';
import 'package:arnuvapp/config/router/export_modulos.dart';

import 'app_router_notifier.dart';

final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: ConstRoutes.SPLASH,
    refreshListenable: goRouterNotifier,
    routes: [
      ///* Primera pantalla
      GoRoute(
        path: ConstRoutes.SPLASH,
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      ///* Navegacion Routes
      GoRoute(
        path: "/",
        builder: (context, state) => const NavegacionScreen(),
      ),

      GoRoute(
        path: ConstRoutes.LOGIN,
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: ConstRoutes.NAVEGACION,
        builder: (context, state) => const NavegacionScreen(),
      ),
      GoRoute(
        path: ConstRoutes.IDIOMA,
        builder: (context, state) => const IdiomaScreen(),
      ),

      GoRoute(
        path: ConstRoutes.REGISTRAR_PERSONA,
        builder: (context, state) => const PersonaDetalleScreen(),
      ),

      GoRoute(
        path: ConstRoutes.REGISTRAR_USUARIO,
        builder: (context, state) => const UsuarioDetalleScreen(),
      ),

      GoRoute(
        path: ConstRoutes.REGISTRAR_CATALOGOS,
        builder: (context, state) => const CatalogoScreen(),
      ),

      GoRoute(
        path: ConstRoutes.REGISTRAR_CATALOGOS_DETALLE,
        builder: (context, state) => const CatalogoDetalleScreen(),
      ),

      GoRoute(
        path: ConstRoutes.REGISTRAR_MODULOS,
        builder: (context, state) => const ModulosScreen(),
      ),

      GoRoute(
        path: ConstRoutes.REGISTRAR_POLITICA_SEGURIDAD,
        builder: (context, state) => const SeguridadPoliticaScreen(),
      ),

      GoRoute(
        path: ConstRoutes.REGISTRAR_ROL,
        builder: (context, state) => const RolScreen(),
      ),

      GoRoute(
        path: ConstRoutes.REGISTRAR_USUARIO_ROL,
        builder: (context, state) => const UsuarioRolScreen(),
      ),
      
      GoRoute(
        path: ConstRoutes.REGISTRAR_MENU,
        builder: (context, state) => const OpcionesPermisosScreen(),
      ),

      GoRoute(
        path: ConstRoutes.REGISTRAR_RECURSOS,
        builder: (context, state) => const RecursosScreen(),
      ),

      GoRoute(
        path: ConstRoutes.REGISTRO_UNIFICADO_USUARIO,
        builder: (context, state) => const RegistroUnificadoUsuarioScreen(),
      ),
      
      // En construccion      
      GoRoute(
        path: ConstRoutes.SESIONES_ACTIVAS,
        builder: (context, state) => PaginaEjemploScreen(),
      ),

      GoRoute(
        path: ConstRoutes.REGISTRAR_PERSONA_DIRECCION,
        builder: (context, state) => PaginaEjemploScreen(),
      ),
      
      // GoRoute(
      //   path: '/',
      //   builder: (context, state) => const ProductsScreen(),
      // ),
      
      ///* Product Routes
      // GoRoute(
      //   path: '/',
      //   builder: (context, state) => const ProductsScreen(),
      // ),
      // GoRoute(
      //   path: '/product/:id',
      //   builder: (context, state) => ProductScreen(
      //     productId: state.params['id'] ?? 'no-id',
      //   ),
      // ),
    ],

    redirect: (context, state) {
      
      final isGoingTo = state.subloc;
      final authStatus = goRouterNotifier.authStatus;

      if ( isGoingTo == ConstRoutes.SPLASH && authStatus == AuthStatus.checking ) return null;

      if ( authStatus == AuthStatus.notAuthenticated ) {
        if ( isGoingTo == ConstRoutes.LOGIN ) return null;

        return ConstRoutes.LOGIN;
      }

      if ( authStatus == AuthStatus.authenticated ) {
        if ( isGoingTo == ConstRoutes.LOGIN || isGoingTo == ConstRoutes.SPLASH ){
          return ConstRoutes.NAVEGACION;
        }
      }


      return null;
    },
  );
});
