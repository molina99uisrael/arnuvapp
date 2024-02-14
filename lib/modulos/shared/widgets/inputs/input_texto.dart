import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arnuvapp/modulos/shared/widgets/inputs/input_decoration.dart';

// Widget que se usa en los formularios
class InputTexto extends StatelessWidget {
  
  final String? hint;
  final bool? obscureText;
  final IconData? prefixIcon;
  final Color? color;
  final String? initialValue;
  final bool? readOnly;
  final TextAlign? textAlign;
  final IconData? suffixIcon;
  final TextInputType? textInputType;
  final String? label;
  final int? maxLines;
  final int? maxLength;
  final Function(String)? onChange;
  final String? Function(String?)? validacion;
  final Function? onTapIcon; // permite realizar algo al presionar en el icono
  final double? espacioTop; 
  final Color? colorIcon; 
  
  const InputTexto({
    Key? key, 
    this.hint,
    this.obscureText,
    this.prefixIcon,
    this.color,
    this.initialValue,
    this.readOnly,
    this.textAlign,
    this.suffixIcon,
    this.textInputType,
    this.label,
    this.maxLines,
    this.maxLength,
    required this.onChange,
    this.validacion,
    this.onTapIcon,
    this.espacioTop = 0.0,
    this.colorIcon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: espacioTop),
        TextFormField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(maxLength ?? 255),
          ],
          initialValue: initialValue,
          autocorrect: false,
          obscureText: obscureText ?? false,
          keyboardType: textInputType,
          readOnly: readOnly ?? false,
          maxLines: maxLines ?? 1,
          textAlign: textAlign ?? TextAlign.left,
          decoration: InputDecorations.inputDecorationPersonalizado(
            hintText: hint ?? '',
            labelText: label ?? '',
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            onTap: onTapIcon,
            colorDecoration: colorIcon == null ?  const Color.fromRGBO(179, 0, 255, 1) : colorIcon!
          ),
          onChanged: onChange,
          validator: validacion
        ),
      ],
    );
  }
}
