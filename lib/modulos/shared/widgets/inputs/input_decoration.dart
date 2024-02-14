import 'package:flutter/material.dart';

class InputDecorations {

  static InputDecoration inputDecorationPersonalizado({
    required String hintText,
    required String labelText,
    double? labelFontSize,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Function? onTap,
    required Color colorDecoration
  }) {
    
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorDecoration,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorDecoration,
          width: 2
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
        color: const Color.fromARGB(255, 66, 66, 66),
        fontSize: labelFontSize
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      focusedErrorBorder:  const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 2
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      prefixIcon: prefixIcon != null 
        ? GestureDetector(onTap: onTap as void Function()?, child: Icon( prefixIcon, color: colorDecoration ))
        : null,
      suffixIcon : suffixIcon != null 
        ? GestureDetector(onTap: onTap as void Function()?, child: Icon( suffixIcon, color: colorDecoration ))
        : null
    );
  }  

}