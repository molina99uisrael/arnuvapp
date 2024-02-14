import 'package:arnuvapp/modulos/autenticacion/autenticacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void mostrarExitoSnackbar( BuildContext context, String message,  WidgetRef ref, [int duracion = 5] ) {

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message), 
      duration: Duration(seconds: duracion),
      backgroundColor: Colors.green,
    )
  );
}

void mostrarErrorSnackBar( BuildContext context, String message, WidgetRef ref, [int duracion = 5] ) {
  if (message == "Token incorrecto") {
    Navigator.pop(context);
    ref.watch(authProvider.notifier).logout(message);
  }
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message), 
      duration: Duration(seconds: duracion),
      backgroundColor: Theme.of(context).colorScheme.error,
    )
  );
}