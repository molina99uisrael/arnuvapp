import 'dart:math';

import 'package:flutter/material.dart';

class InicioBackground extends StatelessWidget {

  final Widget child;

  final boxDecoration = const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.2, 0.8],
        colors: [
          Color(0xff2E305F),
          Color(0xff202333)
        ]
      )
  );

  const InicioBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Purple Gradinet
        Container(decoration: boxDecoration ),

        // Violeta box
        Positioned(
          top: -100,
          left: -30,
          child: _VioletaBox()
        ),

        child,
      ],
    );
  }
}


class _VioletaBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 5,
      child: Container(
        width: 360,
        height: 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 131, 24, 232),
              Color.fromARGB(255, 178, 142, 241)
            ]
          )
        ),
      ),
    );
  }
}
