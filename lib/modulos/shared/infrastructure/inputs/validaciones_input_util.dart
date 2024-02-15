
import 'package:arnuvapp/modulos/shared/shared.dart';
import 'package:formz/formz.dart';

class ValidacionesInputUtil {

  final AppLocalizations localizations;

  ValidacionesInputUtil({
    required this.localizations
  });

  validarEmail ( value ) {
    var email = Email.dirty(value);
    return Formz.validate([ email ]) 
    ? null 
    : email.errorMessage;
    // : localizations.translate('validarEmail');
  }

  validarContrasenia( value ) {
    var password = Password.dirty(value);
    
    return Formz.validate([ password ])
    ? null 
    : password.errorMessage;
    // : localizations.translate('validarPassword');
  }

  validarSoloLetras( value ) {
    // if (value.length < 1) return;
    String pattern = r'^[a-zA-ZáéíóúüÜÁÉÍÓÚÑñ\s]+$';
    RegExp regExp  = RegExp(pattern);
    return regExp.hasMatch(value) 
      ? null 
      : localizations.translate('validarSoloLetras');
  }
  validarLetrasNumeros( value ) {
    // if (value.length < 1) return;
    String pattern = r'^[a-zA-ZáéíóúüÜÁÉÍÓÚÑñ0-9\s]+$';
    RegExp regExp  = RegExp(pattern);
    return regExp.hasMatch(value) 
      ? null 
      : localizations.translate('validarLetrasNumeros');
  }

  validarSoloNumeros( value ) {
    // if (value.length < 1) return;
    String pattern = r'^[0-9]+$';
    RegExp regExp  = RegExp(pattern);
    return regExp.hasMatch(value) 
      ? null 
      : localizations.translate('validarSoloNumeros');
  }
  
  // valida el ingreso del nombre de usuario
  static validarNombreUsuario( String value, String msg ) {
    if (value.isEmpty) return;
    if (value.length < 12) return;
    String pattern = r'^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{12,16}$';
    RegExp regExp  = RegExp(pattern);
    return regExp.hasMatch(value) 
      ? null 
      : msg;
  }

  static validarPoliticaSeguridad( String value, int metodo ) {
    if (value.isEmpty) return false;
    var aux = false;
    // String pattern = r'^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{12,16}$';
    switch (metodo) {
      case 0: // valida Tamanio de caracteres
        String pattern = r'^\S{12,16}$';
        RegExp regExp  = RegExp(pattern);
        aux = regExp.hasMatch(value);
        break;
      case 1: // valida Mayusculas
        String pattern = r'^(?=\w*[A-Z])\S{1,16}$';
        RegExp regExp  = RegExp(pattern);
        aux = regExp.hasMatch(value);
        break;
      case 2: // valida Minusculas
        String pattern = r'^(?=\w*[a-z])\S{1,16}$';
        RegExp regExp  = RegExp(pattern);
        aux = regExp.hasMatch(value);
        break;
      case 3: // valida Numero
        String pattern = r'^(?=\w*[0-9])\S{1,16}$';
        RegExp regExp  = RegExp(pattern);
        aux = regExp.hasMatch(value);
        break;
      default:
    }
    return aux;
  }

  validarCedula( String value ) {
    if (value.isEmpty) return;
    String pattern = r'^([0-9])*\S{10,10}$';
    RegExp regExp  = RegExp(pattern);
    return regExp.hasMatch(value) 
      ? null 
      : localizations.translate('validaCedula');
  }
}