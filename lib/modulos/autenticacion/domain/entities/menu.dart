// To parse this JSON data, do
//
//     final menuResponse = menuResponseFromJson(jsonString);

import 'dart:convert';

import 'package:arnuvapp/modulos/autenticacion/domain/entities/user.dart';

MenuResponse menuResponseFromJson(String str) => MenuResponse.fromJson(json.decode(str));

String menuResponseToJson(MenuResponse data) => json.encode(data.toJson());

class MenuResponse {
    User dto;
    List<Menu> lista;

    MenuResponse({
        required this.dto,
        required this.lista,
    });

    factory MenuResponse.fromJson(Map<String, dynamic> json) => MenuResponse(
        dto: User.fromJson(json["dto"]),
        lista: List<Menu>.from(json["lista"].map((x) => Menu.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "dto": dto.toJson(),
        "lista": List<dynamic>.from(lista.map((x) => x.toJson())),
    };
}

class Menu {
    int idopcion;
    String nombre;
    List<Item> items;

    Menu({
        required this.idopcion,
        required this.nombre,
        required this.items,
    });

    factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        idopcion: json["idopcion"],
        nombre: json["nombre"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idopcion": idopcion,
        "nombre": nombre,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Item {
    int? index;
    int? idrol;
    int? eliminar;
    String? ruta;
    int? idmodulo;
    int? editar;
    int? idopcion;
    String? nombre;
    int? idrecurso;
    int? crear;

    Item({
        this.index,
        this.idrol,
        this.eliminar,
        this.ruta,
        this.idmodulo,
        this.editar,
        this.idopcion,
        this.nombre,
        this.idrecurso,
        this.crear,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        index: json["index"],
        idrol: json["idrol"],
        eliminar: json["eliminar"],
        ruta: json["ruta"],
        idmodulo: json["idmodulo"],
        editar: json["editar"],
        idopcion: json["idopcion"],
        nombre: json["nombre"],
        idrecurso: json["idrecurso"],
        crear: json["crear"],
    );

    Map<String, dynamic> toJson() => {
        "index": index, 
        "idrol": idrol, 
        "eliminar": eliminar,
        "ruta": ruta,
        "idmodulo": idmodulo,
        "editar": editar,
        "idopcion": idopcion,
        "nombre": nombre,
        "idrecurso": idrecurso,
        "crear": crear,
    };
}
