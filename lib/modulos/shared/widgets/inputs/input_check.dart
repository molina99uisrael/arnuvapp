

import 'package:flutter/material.dart';

class InputCheck extends StatelessWidget {


  const InputCheck({
    super.key,
    required this.label,
    required this.onChanged,
    required this.initialValue,
    this.enabled = true,
  });

  final String label;
  final bool? initialValue;
  final bool? enabled;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text( label,
        style: TextStyle( color: Theme.of(context).primaryColor)),
      controlAffinity: ListTileControlAffinity.leading,
      checkColor: Colors.white,
      onChanged: onChanged, 
      value: initialValue,
      enabled: enabled,
    );
  }

}