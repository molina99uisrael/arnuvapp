import 'package:arnuvapp/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void aletaDialogoIOS( {
    required BuildContext context, 
    required Widget titulo, // titulo del dialogo
    required List<Widget> children, // Llega el contenido del dialogo
    List<Widget>? actions, // Puede enviar la lista de botones
    btnCancelar = false, // permite ver el boton por defecto de Cancelar
    btnOk = false, // permite ver el boton por defecto de Ok
    Function()? onPressedCancel, // Si necesita otro comportamiento el boton de cancelar
    Function()? onPressedOk // Si necesita otro comportamiento el boton de Ok
  } ) {

    showCupertinoDialog(
      barrierDismissible: false,
      context: context, 
      builder: ( context ) {
        return CupertinoAlertDialog(
          title: titulo,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
          actions: actions ?? [
            if (btnCancelar)
              TextButton(
                onPressed: onPressedCancel ?? () => Navigator.pop(context),
                child: const Text('Cancelar')
              ),

            if (btnOk)
              TextButton(
                onPressed: onPressedOk ?? () => Navigator.pop(context),
                child: const Text('Ok')
              ),
          ],
        );
      }
    );
}

void aletaDialogAndroid( {
    required BuildContext context, 
    required Widget titulo, // titulo del dialogo
    required List<Widget> children, // Llega el contenido del dialogo
    List<Widget>? actions, // Puede enviar la lista de botones
    btnCancelar = false, // permite ver el boton por defecto de Cancelar
    btnOk = false, // permite ver el boton por defecto de Ok
    Function()? onPressedCancel, // Si necesita otro comportamiento el boton de cancelar
    Function()? onPressedOk, // Si necesita otro comportamiento el boton de Ok
    labelBtnOk = 'btnOk',
    labelBtnCancel = 'btnCancelar',
    esformValido = true
  } ) {
  
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: ( context ) {
        final localizations = AppLocalizations.of(context);
        return AlertDialog(
          scrollable: true,
          elevation: 5,
          title: titulo,
          shape: RoundedRectangleBorder( borderRadius: BorderRadiusDirectional.circular(15) ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
          actions: actions ?? [
            if (btnCancelar)
              TextButton(
                onPressed: onPressedCancel ?? () => Navigator.pop(context),
                child: Text( localizations.translate(labelBtnCancel))
              ),

            if (btnOk)
              TextButton(
                onPressed: onPressedOk ?? () => Navigator.pop(context),
                child: Text(localizations.translate(labelBtnOk))
              ),
          ],
        );
        
      }
    );

}


void aletaEliminaReg( {
    required BuildContext context,
    Function()? onPressedOk
  } ) {
    final localizations = AppLocalizations.of(context);
    aletaDialogAndroid(context: context, titulo: Text(localizations.translate("digTitEliminar")), 
      children: [Text(localizations.translate("digMsgEliminar"))],
      btnOk: true,
      onPressedOk: onPressedOk,
      btnCancelar: true
    );
}

void dialogRegister( {
    required BuildContext context,
    required List<Widget> children,
    bool esregistrar = true,
  } ) {
    final localizations = AppLocalizations.of(context);
    aletaDialogAndroid(context: context, 
      titulo: esregistrar ? Text(localizations.translate("digTitRegistrar")) : Text(localizations.translate("digTitEditar")), 
      children: children,
      btnOk: false,
      btnCancelar: false,
      actions: null
    );
}