// To parse this JSON data, do
//
//     final recursosResponse = recursosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:arnuvapp/modulos/generales/domain/domain.dart';

RecursosResponse recursosResponseFromJson(String str) => RecursosResponse.fromJson(json.decode(str));

String recursosResponseToJson(RecursosResponse data) => json.encode(data.toJson());

class RecursosResponse {
    dynamic mensaje;
    dynamic codigo;
    dynamic dto;
    List<Recursos> lista;

    RecursosResponse({
        this.mensaje,
        this.codigo,
        this.dto,
        required this.lista,
    });

    RecursosResponse copyWith({
        dynamic mensaje,
        dynamic codigo,
        dynamic dto,
        List<Recursos>? lista,
    }) => 
        RecursosResponse(
            mensaje: mensaje ?? this.mensaje,
            codigo: codigo ?? this.codigo,
            dto: dto ?? this.dto,
            lista: lista ?? this.lista,
        );

    factory RecursosResponse.fromJson(Map<String, dynamic> json) => RecursosResponse(
        mensaje: json["mensaje"],
        codigo: json["codigo"],
        dto: json["dto"],
        lista: List<Recursos>.from(json["lista"].map((x) => Recursos.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "codigo": codigo,
        "dto": dto,
        "lista": List<dynamic>.from(lista.map((x) => x.toJson())),
    };
}

class Recursos {
    RecursosId id;
    Modulos idmodulo;
    String nombre;
    String ruta;

    Recursos({
        required this.id,
        required this.idmodulo,
        required this.nombre,
        required this.ruta,
    });

    Recursos copyWith({
        RecursosId? id,
        Modulos? idmodulo,
        String? nombre,
        String? ruta,
    }) => 
        Recursos(
            id: id ?? this.id,
            idmodulo: idmodulo ?? this.idmodulo,
            nombre: nombre ?? this.nombre,
            ruta: ruta ?? this.ruta,
        );

    factory Recursos.fromJson(Map<String, dynamic> json) => Recursos(
        id: RecursosId.fromJson(json["id"]),
        idmodulo: Modulos.fromJson(json["idmodulo"]),
        nombre: json["nombre"],
        ruta: json["ruta"],
    );

    Map<String, dynamic> toJson() => {
        "id": id.toJson(),
        "idmodulo": idmodulo.toJson(),
        "nombre": nombre,
        "ruta": ruta,
    };

    Recursos clone() => Recursos(
      id: id,
      idmodulo: idmodulo,
      nombre: nombre,
      ruta: ruta,
    );
}

class RecursosId {
    int idrecurso;
    int idmodulo;

    RecursosId({
        required this.idrecurso,
        required this.idmodulo,
    });

    RecursosId copyWith({
        int? idrecurso,
        int? idmodulo,
    }) => 
        RecursosId(
            idrecurso: idrecurso ?? this.idrecurso,
            idmodulo: idmodulo ?? this.idmodulo,
        );

    factory RecursosId.fromJson(Map<String, dynamic> json) => RecursosId(
        idrecurso: json["idrecurso"],
        idmodulo: json["idmodulo"],
    );

    Map<String, dynamic> toJson() => {
        "idrecurso": idrecurso,
        "idmodulo": idmodulo,
    };

    @override
    String toString() {
      return '$idmodulo-$idrecurso';
    }

    RecursosId clone() => RecursosId(
      idrecurso: idrecurso,
      idmodulo: idmodulo,
    );
}

final recursoDefault =  Recursos(
      id: RecursosId(idrecurso: 0, idmodulo: 0).clone(),
      idmodulo: modulosDefault.clone(),
      nombre: "",
      ruta: "",
    );