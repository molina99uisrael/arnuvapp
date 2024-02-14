import 'package:flutter/material.dart';

class TituloSeccionWidget extends StatelessWidget {
  final IconData icondata;
  final String texto;
  const TituloSeccionWidget({
    super.key,
    this.icondata = Icons.person,
    this.texto = ''
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          children: <Widget>[
            Icon(icondata),
            const SizedBox(width: 10),
            Text(texto, style: textStyle.titleSmall ),
          ],
        ),
        const Divider()
      ],
    );
  }
}