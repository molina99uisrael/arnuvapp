import 'package:arnuvapp/modulos/shared/shared.dart';
import 'package:flutter/material.dart';

class BotonesForm extends StatelessWidget {
  final bool esValidoForm;
  final Function()? onPressedOk;

  const BotonesForm({
    super.key,
    required this.esValidoForm,
    required this.onPressedOk,
  });


  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 254, 183, 178)),
                // foregroundColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 255, 255, 255))
              ),
              onPressed: () => Navigator.pop(context),
              child: Text( localizations.translate('btnCancelar'))
            ),      
            const SizedBox(width: 15),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 159, 255, 162)),
                // foregroundColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 255, 255, 255))
              ),
              onPressed: esValidoForm 
                ? onPressedOk ?? () => Navigator.pop(context)
                : null,
              child: Text(localizations.translate('btnGuardar'))
            ),
          ],
        ),
      ],
    );
  }
}