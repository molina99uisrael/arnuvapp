// To parse this JSON data, do
//
//     final rolResponse = rolResponseFromJson(jsonString);

import 'dart:convert';

import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';

RolResponse rolResponseFromJson(String str) => RolResponse.fromJson(json.decode(str));

String rolResponseToJson(RolResponse data) => json.encode(data.toJson());

class RolResponse {
    dynamic mensaje;
    dynamic codigo;
    dynamic dto;
    List<Rol> lista;

    RolResponse({
        this.mensaje,
        this.codigo,
        this.dto,
        required this.lista,
    });

    RolResponse copyWith({
        dynamic mensaje,
        dynamic codigo,
        dynamic dto,
        List<Rol>? lista,
    }) => 
        RolResponse(
            mensaje: mensaje ?? this.mensaje,
            codigo: codigo ?? this.codigo,
            dto: dto ?? this.dto,
            lista: lista ?? this.lista,
        );

    factory RolResponse.fromJson(Map<String, dynamic> json) => RolResponse(
        mensaje: json["mensaje"],
        codigo: json["codigo"],
        dto: json["dto"],
        lista: List<Rol>.from(json["lista"].map((x) => Rol.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "codigo": codigo,
        "dto": dto,
        "lista": List<dynamic>.from(lista.map((x) => x.toJson())),
    };
}

class Rol {
    int id;
    SeguridadPolitica idpolitica;
    String nombre;
    bool activo;

    Rol({
        required this.id,
        required this.idpolitica,
        required this.nombre,
        required this.activo,
    });

    Rol copyWith({
        int? id,
        SeguridadPolitica? idpolitica,
        String? nombre,
        bool? activo,
    }) => 
        Rol(
            id: id ?? this.id,
            idpolitica: idpolitica ?? this.idpolitica,
            nombre: nombre ?? this.nombre,
            activo: activo ?? this.activo,
        );

    factory Rol.fromJson(Map<String, dynamic> json) => Rol(
        id: json["id"],
        idpolitica: SeguridadPolitica.fromJson(json["idpolitica"]),
        nombre: json["nombre"],
        activo: json["activo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idpolitica": idpolitica.toJson(),
        "nombre": nombre,
        "activo": activo,
    };

    Rol clone() => Rol(
      id: id,
      idpolitica: idpolitica,
      nombre: nombre,
      activo: activo,
    );
}


final rolDefault = Rol(
      id: 0,
      idpolitica: seguridadPoliticaDefault.clone(),
      nombre: "",
      activo: false,
    );