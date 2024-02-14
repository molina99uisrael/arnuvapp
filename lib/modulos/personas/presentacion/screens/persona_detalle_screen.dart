import 'package:arnuvapp/modulos/generales/domain/entities/catalogo_detalle_response.dart';
import 'package:arnuvapp/modulos/generales/presentacion/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/personas/presentacion/providers/providers.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';
import 'package:flutter/material.dart';

class PersonaDetalleScreen extends ConsumerWidget {
  const PersonaDetalleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final lregistros = ref.watch(personaDetalleProvider).lregistros;

    ref.listen(personaDetalleProvider, (ArnuvState? previous , ArnuvState next) {
      if ( next.errorMessage.isEmpty ) return;
      mostrarErrorSnackBar( context, next.errorMessage, ref );
    });

    return Scaffold(
      appBar: AppBar(title: Text(localizations.translate('AppTitPersona')) ),
        body: Column(
          children: [
            DataTableArnuv(nombreTabla: "Personas",
            columnsName: const ['Nombres','Apellidos','Email'],
            onNew: () {
              ref.watch(personaDetalleProvider.notifier).limpiarRegistro();
              dialogRegister(context: context,
                children: [_Formulario( onPressedOk: () {
                  ref.watch(personaDetalleProvider.notifier).guardar();
                  Navigator.pop(context);
                })],
              );
            },
            onDelete: (index) {
              aletaEliminaReg(context: context,
                onPressedOk: () {
                  ref.watch(personaDetalleProvider.notifier).eliminar(lregistros[index]);
                  Navigator.pop(context);
                },
              );
            },
            onEdit: (index) {
              ref.watch(personaDetalleProvider.notifier).seleccionaRegistro(lregistros[index]);
              dialogRegister(context: context,
                esregistrar: false,
                children: [_Formulario(
                  esActualizar: true,
                  onPressedOk: () {
                    ref.watch(personaDetalleProvider.notifier).actualizar(lregistros[index]);
                    Navigator.pop(context);
                  }
                )],
              );
            },
            rowTablas: [...lregistros.map((e) {
                  List<Widget> lista = [];
                  lista.add(Text(e.nombres));
                  lista.add(Text(e.apellidos));
                  lista.add(Text(e.email));
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
    final state = ref.watch(personaDetalleProvider);
    final metodos = ref.read(personaDetalleProvider.notifier);

    // Sacar informacion del dropdown por defecto
    final stateCatalogoDetalle = ref.watch(catalogoDetalleDropdownProvider);
    final metodosCatalogoDetalle = ref.watch(catalogoDetalleDropdownProvider.notifier);
    if (stateCatalogoDetalle.idcatalogo == 0) {
      metodosCatalogoDetalle.listarCatalogDetalle(1);
    }
    
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
                initialValue: state.registro.nombres,
                textInputType: TextInputType.text,
                label: localizations.translate('lblNombres'),
                maxLength: 120,
                onChange: (value) => state.registro.nombres = value,          
                validacion: (valor) => valiacion.validarSoloLetras(valor)
              ),
              InputTexto(
                initialValue: state.registro.apellidos,
                espacioTop: 20.0,
                textInputType: TextInputType.text,
                label: localizations.translate('lblApellidos'),
                maxLength: 120,
                onChange: (value) => state.registro.apellidos = value,    
                validacion: (valor) => valiacion.validarSoloLetras(valor)         
              ),
              InputTexto(
                initialValue: state.registro.identificacion,
                espacioTop: 20.0,
                textInputType: TextInputType.number,
                label: localizations.translate('lblIdentificacion'),
                maxLength: 15,
                onChange: (value) => state.registro.identificacion = value,  
                validacion: (valor) => valiacion.validarSoloNumeros(valor)              
              ),
              InputTexto(
                initialValue: state.registro.celular,
                espacioTop: 20.0,
                textInputType: TextInputType.phone,
                label: localizations.translate('lblCelular'),
                maxLength: 20,
                onChange: (value) => state.registro.celular = value, 
                validacion: (valor) => valiacion.validarSoloNumeros(valor)         
              ),
              InputTexto(
                initialValue: state.registro.email,
                espacioTop: 20.0,
                textInputType: TextInputType.emailAddress,
                label: localizations.translate('lblEmil'),
                maxLength: 150,
                onChange: (value) => state.registro.email = value, 
                validacion: (valor) => valiacion.validarEmail(valor)             
              ),
              DropdownPersonalizado(
                label: localizations.translate('lblTipoIdentificacion'),
                porcentajeWidth: 0.6,
                transaparente: true,
                value: stateCatalogoDetalle.registroSelect.id.iddetalle.toString(), 
                onchange: metodosCatalogoDetalle.onSeleccionChange,
                items: stateCatalogoDetalle.lregistros.map<DropdownMenuItem<String>>((CatalogoDetalle value) {
                  return DropdownMenuItem<String>(
                    value: value.id.iddetalle.toString(),
                    child: Text(value.nombre),
                  );
                }).toList(),
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

