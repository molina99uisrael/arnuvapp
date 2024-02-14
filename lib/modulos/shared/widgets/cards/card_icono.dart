import 'dart:ui';
import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';

class CardContenidoIcono extends StatelessWidget {

  final String image;
  final IconData? icon;
  final Color color;
  final String text;
  final Function? onTap;

  const CardContenidoIcono({
    Key? key,
    this.icon,
    required this.image,
    required this.color,
    required this.text,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context);
    return _CardPadreFondo(
      onTap: onTap as void Function()?,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(181, 227, 225, 225),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: textStyles.cardColor,
              borderRadius: BorderRadius.circular(15)
            ),
            child: image.isNotEmpty
              ? FadedScaleAnimation( child: Image.asset( image, scale: 3 ) )
              : FadedScaleAnimation( 
                  child: Icon( icon, size: 30, color: textStyles.primaryColor )
                )
          ),
          const SizedBox( height: 10 ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text( 
              text, 
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
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur( sigmaX: 5, sigmaY: 5 ),
          child: Container(
            padding: const EdgeInsets.only(top: 10.0),
            child: child,
          ),
        ),
      ),
    );
  }
}