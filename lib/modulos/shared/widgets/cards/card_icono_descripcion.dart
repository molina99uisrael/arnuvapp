import 'dart:ui';
import 'package:flutter/material.dart';

class CardContenidoIconoDescripcion extends StatelessWidget {

  final IconData icon;
  final Color color;
  final String text;
  final Function? onTap;

  const CardContenidoIconoDescripcion({
    Key? key,
    required this.icon,
    required this.color,
    required this.text,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

      return _CardPadreFondo(
        onTap: onTap as void Function()?,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: 25,
              child: Icon( icon, size: 30, color: Colors.white ),
            ),
            const SizedBox( height: 10 ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text( 
                text , 
                textAlign: TextAlign.center, 
                style: TextStyle( color: color, fontSize: 16 )
              )
            )
          ],
        )
      );
  }
}


class _CardPadreFondo extends StatelessWidget {

  final Widget child;
  final Function? onTap;

  const _CardPadreFondo({
    Key? key, 
    required this.child,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        margin: const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur( sigmaX: 5, sigmaY: 5 ),
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                color: const Color.fromARGB(181, 227, 225, 225),
                borderRadius: BorderRadius.circular(20)
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}