

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/autenticacion/presentacion/providers/providers.dart';
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/presentacion/providers/providers.dart';
import 'package:arnuvapp/modulos/personas/presentacion/providers/providers.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

class RegistroUnificadoUsuarioScreen extends ConsumerWidget {
  const RegistroUnificadoUsuarioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    ref.listen(usuarioUnificadoFormProvider, (ArnuvState? previous , ArnuvState next) {
      if ( next.errorMessage.isNotEmpty ) {
        mostrarErrorSnackBar( context, next.errorMessage, ref );
      }
      if ( next.succesMessage.isNotEmpty ) {
        mostrarExitoSnackbar( context, next.succesMessage, ref, 10);
      }
    });
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.translate('AppTitRegistroUsuario')) ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox( height: 100 ),
              CardContainer(
                height: 870,
                width: (size.width > 600) ? size.width * 0.5 : size.width,
                child: const _Formulario(onPressedOk: null)
              )
            ]
        )
      )
    );
  }
}

class _Formulario extends ConsumerWidget {

  final Function()? onPressedOk;

  const _Formulario({
    required this.onPressedOk,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);

    final stateForm = ref.watch(usuarioUnificadoFormProvider);
    final metodosForm = ref.read(usuarioUnificadoFormProvider.notifier);

    final stateRol = ref.watch(rolDropdownProvider);

    // Sacar informacion del dropdown por defecto
    final stateCatalogoDetalle = ref.watch(catalogoDetalleDropdownProvider);
    final metodosCatalogoDetalle = ref.watch(catalogoDetalleDropdownProvider.notifier);
    if (stateCatalogoDetalle.idcatalogo == 0) {
      metodosCatalogoDetalle.listarCatalogDetalle(1);
    }

    final size = MediaQuery.of(context).size;
    
    final validacion = ValidacionesInputUtil(localizations: localizations);
    return Column(
      children: [
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: stateForm.formKey,
          onChanged: metodosForm.esFormularioValido,
          child: Column(
            children: [
              InputTexto(
                initialValue: stateForm.registro.nombres,
                textInputType: TextInputType.text,
                label: localizations.translate('lblNombres'),
                maxLength: 120,
                onChange: (value) => stateForm.registro.nombres = value,          
                validacion: (valor) => validacion.validarSoloLetras(valor)
              ),
              InputTexto(
                initialValue: stateForm.registro.apellidos,
                espacioTop: 20.0,
                textInputType: TextInputType.text,
                label: localizations.translate('lblApellidos'),
                maxLength: 120,
                onChange: (value) => stateForm.registro.apellidos = value,    
                validacion: (valor) => validacion.validarSoloLetras(valor)         
              ),
              DropdownPersonalizado(
                label: localizations.translate('lblTipoIdentificacion'),
                porcentajeWidth: (size.width > 600) ? 0.3 : 0.5,
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
              InputTexto(
                initialValue: stateForm.registro.identificacion,
                textInputType: TextInputType.number,
                label: localizations.translate('lblIdentificacion'),
                maxLength: 15,
                onChange: (value) => stateForm.registro.identificacion = value,  
                validacion: (valor) => validacion.validarSoloNumeros(valor)              
              ),
              InputTexto(
                initialValue: stateForm.registro.celular,
                espacioTop: 20.0,
                textInputType: TextInputType.phone,
                label: localizations.translate('lblCelular'),
                maxLength: 20,
                onChange: (value) => stateForm.registro.celular = value, 
                validacion: (valor) => validacion.validarSoloNumeros(valor)         
              ),
              InputTexto(
                initialValue: stateForm.registro.email,
                espacioTop: 20.0,
                textInputType: TextInputType.emailAddress,
                label: localizations.translate('lblEmil'),
                maxLength: 150,
                onChange: (value) => stateForm.registro.email = value, 
                validacion: (valor) => validacion.validarEmail(valor)             
              ),
              InputTexto(
                initialValue: stateForm.registro.username,
                espacioTop: 20.0,
                textInputType: TextInputType.text,
                label: localizations.translate('lblUsuario'),
                maxLength: 120,
                onChange: (value) => stateForm.registro.username = value,
                validacion: (valor) => validacion.validarLetrasNumeros(valor),
              ),
              InputTextoOculto(
                mostrarTexto: true,
                espacioTop: 20.0,
                label: localizations.translate('lblContrasenia'),
                maxLength: 16,
                onChange: (value) => stateForm.registro.password = value,
                validacion: (value) => validacion.validarContrasenia(value),
              ),
              DropdownPersonalizado(
                label: localizations.translate('lblSelRol'),
                value: stateRol.registroSelect.id.toString(),
                porcentajeWidth: (size.width > 600) ? 0.3 : 0.5,
                onchange: ref.watch(rolDropdownProvider.notifier).onSeleccionChange,
                items: stateRol.lregistros.map<DropdownMenuItem<String>>((Rol value) {
                  return DropdownMenuItem<String>(
                    value: value.id.toString(),
                    child: Text(value.nombre),
                  );
                }).toList(),
              ),
              
              
              _BotonesFormulario(metodosForm: metodosForm, localizations: localizations, stateForm: stateForm),
              
            ],
          )
        
        )

      ],
    );
  }
}

class _BotonesFormulario extends ConsumerWidget {
  const _BotonesFormulario({
    required this.metodosForm,
    required this.localizations,
    required this.stateForm,
  });

  final UsuarioUnificadoFormNotifier metodosForm;
  final AppLocalizations localizations;
  final UsuarioUnificadoFormState stateForm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 254, 183, 178)),
          ),
          onPressed: () {
            metodosForm.refrescar(context, ()=>ref.refresh(usuarioUnificadoFormProvider));
          },
          child: Text( localizations.translate('btnRefrescar'))
        ),      
        const SizedBox(width: 15),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 159, 255, 162)),
          ),
          onPressed: stateForm.esValidoForm 
            ? () {
              metodosForm.guardar(context,()=>ref.refresh(usuarioUnificadoFormProvider));
            } 
            : null,
          child: Text(localizations.translate('btnGuardar'))
        ),
      ],
    );
  }
}

