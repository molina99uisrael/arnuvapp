import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arnuvapp/modulos/shared/widgets/inputs/input_decoration.dart';

// Widget que se usa para ocultar texto como pin y contraseñas
class InputTextoOculto extends StatelessWidget {
  
  final String? hint;
  final IconData? prefixIcon;
  final Color? color;
  final String? initialValue;
  final bool? readOnly;
  final TextAlign? textAlign;
  final IconData? suffixIcon;
  final String? label;
  final int? maxLines;
  final int? maxLength;
  final Function(String)? onChange;
  final String? Function(String?)? validacion;
  final Function? onTapIcon; // permite realizar algo al presionar en el icono
  final bool mostrarTexto; // permite realizar algo al presionar en el icono
  final double? espacioTop; 

  const InputTextoOculto({
    Key? key, 
    this.hint,
    this.prefixIcon,
    this.color,
    this.initialValue,
    this.readOnly,
    this.textAlign,
    this.suffixIcon,
    this.label,
    this.maxLines,
    this.maxLength,
    required this.onChange,
    required this.mostrarTexto,
    this.validacion,
    this.espacioTop = 0.0,
    this.onTapIcon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: espacioTop),
        TextFormField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(maxLength ?? 255),
          ],
          autocorrect: false,
          obscureText: mostrarTexto,
          keyboardType: TextInputType.visiblePassword,
          readOnly: readOnly ?? false,
          maxLines: maxLines ?? 1,
          textAlign: textAlign ?? TextAlign.left,
          onChanged: onChange,
          validator: validacion,
          decoration: InputDecorations.inputDecorationPersonalizado(
            hintText: hint ?? '',
            labelText: label ?? '',
            prefixIcon: prefixIcon,
            suffixIcon: mostrarTexto ? Icons.visibility: Icons.visibility_off,
            onTap: onTapIcon,
            colorDecoration: const Color.fromRGBO(179, 0, 255, 1)
          )
        ),
      ],
    );
  }
}

// class InputTextoOcultoController extends GetxController {
//   RxBool mostrarTextoContrasenia = true.obs;
//   RxBool mostrarTextoRepetir = true.obs;

//   onMostrarContrasenia() {
//     mostrarTextoContrasenia.value = !mostrarTextoContrasenia.value;
//   }
//   onMostrarContraseniaRepetida() {
//     mostrarTextoRepetir.value = !mostrarTextoRepetir.value;
//   }
// }