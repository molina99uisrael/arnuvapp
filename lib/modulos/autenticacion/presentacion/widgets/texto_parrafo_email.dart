
import 'package:flutter/material.dart';

class TextoParrafoEmail extends StatelessWidget {
  final String email;
  final String texto;
  const TextoParrafoEmail({ Key? key, required this.email, required this.texto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context);
    return Center(
      child: Column(
        children: [
          Text(
            texto,
            textAlign: TextAlign.justify,
            style: textStyle.textTheme.titleSmall,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Text(
              email,
              textAlign: TextAlign.justify,
              style: textStyle.textTheme.titleLarge,
            )
          ),
        ],
      ),
    );
  }
}