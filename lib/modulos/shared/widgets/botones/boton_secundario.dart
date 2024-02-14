import 'package:flutter/material.dart';
import 'package:arnuvapp/config/locale/app_localizations.dart';

class BotonSecundario extends StatelessWidget {
  final double? height;
  final double? width;
  final String? label;
  final Function? onPressed;
  final Color? textColor;
  final double? radius;
  final double? mt;
  final double? mb; 
  final double? ml;
  final double? mr; 
  final Color? color;
  final TextStyle? textStyle;
  final double? px;
  final double? py;

  const BotonSecundario({
    Key? key, 
    required this.label,
    this.onPressed,
    this.radius,
    this.height,
    this.width,
    this.color,
    this.mt, 
    this.mb,
    this.ml, 
    this.mr,
    this.textStyle,
    this.textColor,
    this.px,
    this.py,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(
        top: mt ?? 0,
        bottom: mb ?? 0,
        left: ml ?? 0,
        right: mr ?? 0
      ),
      child: ElevatedButton(
        onPressed: onPressed as void Function()?,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 10.0),
          ),
          padding: EdgeInsets.symmetric( 
            horizontal: px ?? 10, 
            vertical: py ?? 15
          ),
        ),
        child: SizedBox(
          height: height,
          width: width ?? double.infinity,
          child: Text(
            label ?? localizations.translate('btnContinuar'),
            textAlign: TextAlign.center,
            style: textStyle ??
                Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: textColor ?? Theme.of(context).scaffoldBackgroundColor),
          ),
        ),
      ),
    );
  }
}
