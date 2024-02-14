


import 'package:flutter/widgets.dart';

class ItemsOperaciones {

  String image;
  IconData? icon;
  String? title;
  Function onTap;
  
  ItemsOperaciones({
    required this.image, 
    this.icon, 
    this.title, 
    required this.onTap
  });

}
