import 'package:arnuvapp/modulos/shared/widgets/datatable/data_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class Ejemplo {
  final int id;
  final String nombre;
  final String email;
  Ejemplo({
    required this.id,
    required this.nombre,
    required this.email
  });

}

class PaginaEjemploScreen extends ConsumerWidget {
  final lregistros = [
    Ejemplo(id: 1, email: "jskld@gmail.com", nombre: "Nombre 1" ),
    Ejemplo(id: 2, email: "jskld@gmail.com", nombre: "Nombre 1" ),
    Ejemplo(id: 3, email: "jskld@gmail.com", nombre: "Nombre 1" ),
    Ejemplo(id: 4, email: "jskld@gmail.com", nombre: "Nombre 1" ),
  ];

  PaginaEjemploScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pagina Ejemplo") ),
        body: Column(
          children: [
            DataTableArnuv(nombreTabla: "Ejemplo",
            columnsName: const ['Id','Nombre','Email'],
            onNew: () { },
            onDelete: (index) {},
            onEdit: (index) { },
            rowTablas: [...lregistros.map((e) {
                List<Widget> lista = [];
                lista.add(Text(e.id.toString()));
                lista.add(Text(e.nombre));
                lista.add(Text(e.email));
                return lista;
              })],
            ),

          ]
        )
    );
  }
}
