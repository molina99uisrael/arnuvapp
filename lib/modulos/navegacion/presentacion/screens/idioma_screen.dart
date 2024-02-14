import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/navegacion/presentacion/providers/idioma_provider.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

// Pagina para mostar la lista de idiomas que soporta el sistema
class IdiomaScreen extends ConsumerWidget {
  const IdiomaScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final idioma = ref.watch(idiomaProvider);
    final idiomaNotifier = ref.watch(idiomaProvider.notifier);
    return  Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('cambiarIdioma'))
      ),
      body: ListView.builder(
        itemCount: localizations.localizedValues.length,
        itemBuilder: (__, index) => RadioListTile(
          value: localizations.localizedValues.keys.elementAt(index),
          groupValue: idioma.seleccionLocal,
          title: Text(
            localizations.localizedValues[ 
              localizations.localizedValues.keys.elementAt(index)
            ]!.name,
          ),
          onChanged: (value) => idiomaNotifier.seleccionarLocale(value as String)
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: BotonPrimario(
          label: localizations.translate('btnGuardar'),
          onPressed: () {
            idiomaNotifier.setIdiomaAplicacion(idioma.seleccionLocal, true);
            context.pop();
          },
        )
      )   
    );
  }
}