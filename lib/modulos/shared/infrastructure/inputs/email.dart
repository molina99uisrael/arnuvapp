import 'package:formz/formz.dart';

// Definir errores de validación de entrada
enum EmailError { empty, format }

// Amplíe FormzInput y proporcione el tipo de entrada y el tipo de error.
class Email extends FormzInput<String, EmailError> {

  static final RegExp emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  // Llame a super.pure para representar una entrada de formulario sin modificar.
  const Email.pure() : super.pure('');

  // Llame a super.dirty para representar una entrada de formulario modificada.
  const Email.dirty( String value ) : super.dirty(value);



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == EmailError.empty ) return 'El campo es requerido';
    if ( displayError == EmailError.format ) return 'No tiene formato de correo electrónico';

    return null;
  }

  // Anula el validador para manejar la validación de un valor de entrada determinado.
  @override
  EmailError? validator(String value) {
    
    if ( value.isEmpty || value.trim().isEmpty ) return EmailError.empty;
    if ( !emailRegExp.hasMatch(value) ) return EmailError.format;

    return null;
  }
}