import 'dart:convert';
import 'package:crypto/crypto.dart';

class ArnuvUtils {

  static String hashSHA256(dato) {
    List<int> bytes = utf8.encode(dato);
    String hashed  = sha256.convert(bytes).toString();
    return hashed;
  }


}