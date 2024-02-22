import 'package:flutter/material.dart';

// Boton transparente personalizado a ser reutilizado en el sistema
class BotonTransparente extends StatelessWidget {
  final double? height;
  final double? width;
  final String? label;
  final Widget? icon;
  final double? iconGap;
  final Function? onTap;
  final double? radius;
  final double? mt;
  final double? mb; 
  final double? ml;
  final double? mr;
  final MainAxisAlignment? mainAxisAlignment;

  const BotonTransparente({
    Key? key, 
    required this.label,
    this.icon,
    this.iconGap,
    this.onTap,
    this.radius,
    this.height,
    this.width,
    this.mt, 
    this.mb,
    this.ml, 
    this.mr,
    this.mainAxisAlignment
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8),
          color: Colors.transparent,
        ),
        margin: EdgeInsets.only(
          top: mt ?? 0,
          bottom: mb ?? 0,
          left: ml ?? 0,
          right: mr ?? 0
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          children: [
            icon ?? const SizedBox.shrink(),
            icon != null ? SizedBox(width: iconGap ?? 20) : const SizedBox.shrink(),
            Text(
              // label ?? 'btnContinuar'.tr,
              label ?? 'btnContinuar',
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).primaryColor),
              // style: isDarkMode 
              //   ? const TextStyle(color: Colors.white)
              //   : TextStyle(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}