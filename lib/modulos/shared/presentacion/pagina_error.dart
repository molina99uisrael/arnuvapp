import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class PaginaErrorScreen extends ConsumerWidget {
 
  const PaginaErrorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Column(
        children: [
          Text("Pagina no encontrada")
        ]
      )
    );
  }
}
