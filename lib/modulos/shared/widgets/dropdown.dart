import 'package:flutter/material.dart';

class DropdownPersonalizado extends StatelessWidget {
  final String value;
  final String label;
  final double? width;
  final double horizontal;
  final double vertical;
  final double porcentajeWidth;
  final Function()? onPressed;
  final List<DropdownMenuItem<String>>? items;
  final Function(String?)? onchange;
  final bool transaparente;

  const DropdownPersonalizado({
    super.key,
    required this.value,
    required this.label,
    required this.items,
    required this.onchange,
    this.width,
    this.horizontal = 20.0,
    this.vertical = 10.0,
    this.porcentajeWidth = 0.8,
    this.transaparente = false,
    this.onPressed
  });


  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      width: width ?? size.width,
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      decoration: transaparente ? null : BoxDecoration(color: themeStyle.cardColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width ?? size.width * porcentajeWidth,
                child: DropdownButton<String>(
                  value: value,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  isExpanded: true,
                  style: TextStyle(color: themeStyle.primaryColor),
                  underline: Container(
                    height: 2,
                    color: themeStyle.primaryColor,
                  ),
                  items: items,
                  onChanged: onchange,
                ),
              ),

              if (onPressed != null)
                IconButton(onPressed: onPressed ?? () {}, icon: const Icon(Icons.search))
            ],
          )
        ],
      )
    );
  }
}