

import 'package:arnuvapp/modulos/autenticacion/domain/entities/menu.dart';
import 'package:arnuvapp/modulos/autenticacion/presentacion/providers/autenticacion_provider.dart';
import 'package:arnuvapp/modulos/shared/widgets/mostrar_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DataTableArnuv extends ConsumerWidget {
  final String nombreTabla;
  final List<String> columnsName;
  final List<List<Widget>> rowTablas;
  final Function(int index)? onEdit;
  final Function(int index)? onDelete;
  final Function()? onNew;

  const DataTableArnuv({
    super.key,
    required this.nombreTabla,
    required this.columnsName,
    required this.rowTablas,
    this.onEdit,
    this.onDelete,
    this.onNew
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final itempermisos = ref.read(authProvider).opcionesMenu;
    try {  
      var tableRow = TableCustomRow(rows: rowTablas, itempermisos: itempermisos!, onDelete: onDelete, onEdit: onEdit, numColumn: columnsName.length);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox( height: 50 ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.90,
            child: PaginatedDataTable(
              header: Text(nombreTabla, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onRowsPerPageChanged: (perPage) {},
              rowsPerPage: 5,
              columns: <DataColumn>[
                ..._listaColumnas(columnsName)
              ],
              source: tableRow,
              controller: ScrollController(),
              actions: [
                itempermisos.crear == 0 ? Container()
                  : ElevatedButton.icon(onPressed: onNew, icon: const Icon(Icons.add), 
                    label: const Text("Nuevo"))
              ],
              availableRowsPerPage: const [5,10,15,20],
              showFirstLastButtons: true,
              
            )
          ),
        ],
      );
    } catch (e) {
      mostrarErrorSnackBar( context, e.toString(), ref);
      return const Column(
        children: [
          SizedBox( height: 50 ),
          Text("Tabla")
        ],
      );
    }    
  }

  List<DataColumn> _listaColumnas(List<String> columnsName) {
    var lcolumn = columnsName.map<DataColumn>((e) => DataColumn(
      label: Text(e, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
    )).toList();
    lcolumn.add(const DataColumn(
      label: Text("Acciones", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    ));
    return lcolumn;
  }

}

class TableCustomRow extends DataTableSource {
  final List<List<Widget>> rows;
  final int numColumn;
  int indexSelect = 0;
  Item itempermisos;
  final Function(int index)? onEdit;
  final Function(int index)? onDelete;

  TableCustomRow({
    required this.rows,
    required this.numColumn,
    required this.itempermisos,
    this.onDelete,
    this.onEdit
  });

  @override
  DataRow? getRow(int index) {
    final registors = _listaFilas(rows, itempermisos, index);
    return DataRow.byIndex(index: index, cells: registors.length <= index ? [
      ...generarEspacioBlanco(numColumn)
    ] : registors[index]    
    );
  }

  List<DataCell> generarEspacioBlanco(int numColumn) {
    List<DataCell> lista = [];
    for (var i = 0; i <= numColumn; i++) {
      lista.add(const DataCell(Text("")));
    }
    return lista;
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => rows.length;

  @override
  int get selectedRowCount => indexSelect;

  List<List<DataCell>> _listaFilas(List<List<Widget>> rows, Item itempermisos, int index) {
    
    var lrows = rows.map<List<DataCell>>((e) => e.map( (a) => DataCell(a)).toList() ).toList();
    for (var row in lrows) {
      row.add(DataCell(
        Row(
          children: [
            itempermisos.editar == 0 ? Container() 
              : IconButton(onPressed: () {
                indexSelect = index;
                if (onEdit != null) {
                  onEdit!(index);
                }
              }, icon: const Icon(Icons.edit, color: Colors.blue,)),
            
            itempermisos.eliminar == 0 ? Container() 
              : IconButton(onPressed: () {
                indexSelect = index;
                if (onDelete != null) {
                  onDelete!(index);
                }
              }, icon: const Icon(Icons.delete, color: Colors.red))
          ],
        ),
      ));
    }
    return lrows;
  }
}