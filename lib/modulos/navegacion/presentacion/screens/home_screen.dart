import 'package:arnuvapp/modulos/autenticacion/autenticacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const _HomeScreen()
    );
  }
}

class _HomeScreen extends ConsumerWidget {

  const _HomeScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final themeStyle = Theme.of(context);
    ref.listen(authProvider, (ArnuvState? previous , ArnuvState next) {
      if ( next.errorMessage.isEmpty ) return;
      mostrarErrorSnackBar( context, next.errorMessage, ref);
    });
    // final localizations = AppLocalizations.of(context);
    

    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: const [
          Stack(
            children: [
              TituloBannerHome(),
            ],
          ),
        ],
      ),
    );
  }



}