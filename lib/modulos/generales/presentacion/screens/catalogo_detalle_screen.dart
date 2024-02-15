import 'package:arnuvapp/modulos/generales/domain/entities/catalogo_response.dart';
import 'package:arnuvapp/modulos/generales/presentacion/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';
import 'package:flutter/material.dart';

class CatalogoDetalleScreen extends ConsumerWidget {
  const CatalogoDetalleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final lcatalogos = ref.watch(catalogoDropdownProvider).lregistros;
    final registroSelect = ref.watch(catalogoDropdownProvider).registroSelect;
    final lregistros = ref.watch(catalogoDetalleProvider).lregistros;

    ref.listen(catalogoDetalleProvider, (ArnuvState? previous , ArnuvState next) {
      if ( next.errorMessage.isEmpty ) return;
      mostrarErrorSnackBar( context, next.errorMessage, ref );
    });

    return Scaffold(
      appBar: AppBar(title: Text(localizations.translate('AppTitCatalogoDetalle')) ),
        body: Column(
          children: [
            DropdownPersonalizado(
              label: localizations.translate('lblCatalogo'),
              value: registroSelect.id.toString(), 
              onchange: ref.watch(catalogoDropdownProvider.notifier).onSeleccionChange,
              items: lcatalogos.map<DropdownMenuItem<String>>((Catalogo value) {
                return DropdownMenuItem<String>(
                  value: value.id.toString(),
                  child: Text(value.nombre),
                );
              }).toList(),
              onPressed: () => ref.watch(catalogoDetalleProvider.notifier).listarPorIdCatalogo(registroSelect.id),
            ),
            DataTableArnuv(nombreTabla: "Tabla de Catalogo Detalle",
            columnsName: const ['Id Catalogo','Id Detalle','Nombre','Activo'],
            onNew: () {
              ref.watch(catalogoDetalleProvider.notifier).limpiarRegistro();
              dialogRegister(context: context,
                children: [_Formulario( onPressedOk: () {
                  ref.watch(catalogoDetalleProvider.notifier).guardar();
                  Navigator.pop(context);
                })],
              );
            },
            onDelete: (index) {
              aletaEliminaReg(context: context,
                onPressedOk: () {
                  ref.watch(catalogoDetalleProvider.notifier).eliminar(lregistros[index]);
                  Navigator.pop(context);
                },
              );
            },
            onEdit: (index) {
              ref.watch(catalogoDetalleProvider.notifier).seleccionaRegistro(lregistros[index]);
              dialogRegister(context: context,
                esregistrar: false,
                children: [_Formulario(
                  esActualizar: true,
                  onPressedOk: () {
                    ref.watch(catalogoDetalleProvider.notifier).actualizar(lregistros[index]);
                    Navigator.pop(context);
                  }
                )],
              );
            },
            rowTablas: [...lregistros.map((e) {
                  List<Widget> lista = [];
                  lista.add(Text(e.id.idcatalogo.toString()));
                  lista.add(Text(e.id.iddetalle));
                  lista.add(Text(e.nombre));
                  lista.add(Text(e.activo.toString()));
                  return lista;
                })],
            ),

          ]
        )
    );
  }
}

class _Formulario extends ConsumerWidget {

  final Function()? onPressedOk;
  final bool esActualizar;

  const _Formulario({
    required this.onPressedOk,
    this.esActualizar = false
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final localizations = AppLocalizations.of(context);
    final state = ref.watch(catalogoDetalleProvider);
    final metodos = ref.read(catalogoDetalleProvider.notifier);
    
    final valiacion = ValidacionesInputUtil(localizations: localizations);
    return Column(
      children: [
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: state.formKey,
          onChanged: metodos.esFormularioValido,
          child: Column(
            children: [
              InputTexto(
                initialValue: state.registro.id.idcatalogo.toString(),
                textInputType: TextInputType.number,
                label: localizations.translate('lblCodigoCat'),
                maxLength: 10,
                onChange: (value) => state.registro.id.idcatalogo = int.tryParse(value) ?? 0,
                validacion: (valor) => valiacion.validarSoloNumeros(valor),
                readOnly: true,
              ),
              InputTexto(
                initialValue: state.registro.id.iddetalle.toString(),
                espacioTop: 20.0,
                textInputType: TextInputType.text,
                label: localizations.translate('lblCodigoCatDet'),
                maxLength: 3,
                onChange: (value) => state.registro.id.iddetalle = value,
                validacion: (valor) => valiacion.validarLetrasNumeros(valor),
                readOnly: esActualizar,
              ),
              InputTexto(
                initialValue: state.registro.nombre,
                espacioTop: 20.0,
                textInputType: TextInputType.text,
                label: localizations.translate('lblNombres'),
                maxLength: 100,
                onChange: (value) => state.registro.nombre = value,    
                validacion: (valor) => valiacion.validarSoloLetras(valor)         
              ),
              InputCheck(
                label: localizations.translate('lblCheckActivo'), 
                onChanged: metodos.setCheckActivo,
                initialValue: state.registro.activo,
              ),
              BotonesForm(
                esValidoForm: state.esValidoForm, 
                onPressedOk: onPressedOk
              )
              
            ],
          )
        
        )

      ],
    );
  }
}


