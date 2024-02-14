import 'package:arnuvapp/modulos/autenticacion/autenticacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const _PerfilScreen()
    );
  }
}

class _PerfilScreen extends ConsumerWidget {

  const _PerfilScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeStyle = Theme.of(context);
    final state = ref.watch(authProvider);
    final localizations = AppLocalizations.of(context);

    ref.listen(authProvider, (ArnuvState? previous , ArnuvState next) {
      if ( next.errorMessage.isEmpty ) return;
      mostrarErrorSnackBar( context, next.errorMessage, ref);
    });

    return Scaffold(
      body:FadedSlideAnimation(
        beginOffset: const Offset(0, 0.3),
        endOffset: const Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: ListView(
          children: [
            _cabeceraPerfil(context, ref),                
            CardContainer(
              height: 80,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(localizations.translate('EtiLabelUser'), style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Text(state.user != null ? state.user!.username : ""),
                    ],
                  ),
                  Row(
                    children: [
                      Text(localizations.translate('EtiLabelRol'), style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Text(state.user != null ? state.user!.nrol : ""),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Table(
                children: [
                  TableRow(
                    children: [
                      CardContenidoIconoDescripcion( 
                        color: themeStyle.primaryColor, 
                        icon: Icons.translate, 
                        text: localizations.translate('EtiIdioma'),
                        onTap: () => context.push(ConstRoutes.IDIOMA),
                      ),
                      CardContenidoIconoDescripcion( 
                        color: themeStyle.primaryColor, 
                        icon: Icons.pin_outlined, 
                        text: 'Ejemplo',
                        onTap: () { },
                      ),
                      CardContenidoIconoDescripcion( 
                        color: themeStyle.primaryColor, 
                        icon: Icons.pin_outlined, 
                        text: 'Información',
                        onTap: () {}
                      )
                    ]
                  )
                ]
              ),
            )         
          ],
        ),
      ),
    );
  }


  Stack _cabeceraPerfil(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final themeStyle = Theme.of(context);
    return Stack(
      children: [
        SizedBox(
          height: 150,
          width: size.width,
        ),
        PositionedDirectional(
          start: size.width / 2.75,
          // end: 0,
          top: 20,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(size.width)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size.width),
              // borderRadius: BorderRadius.circular(50),
              child: FadedScaleAnimation(
                child: Icon(Icons.person, size: 110, 
                  weight: 100, color: themeStyle.primaryColor),
              )
            ),
          )
        ),
      ],
    );
  }
}