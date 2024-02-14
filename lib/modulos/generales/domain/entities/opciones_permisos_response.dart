// To parse this JSON data, do
//
//     final opcionesPermisosResponse = opcionesPermisosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:arnuvapp/modulos/autenticacion/domain/entities/rol_response.dart';
import 'package:arnuvapp/modulos/generales/domain/domain.dart';

OpcionesPermisosResponse opcionesPermisosResponseFromJson(String str) => OpcionesPermisosResponse.fromJson(json.decode(str));

String opcionesPermisosResponseToJson(OpcionesPermisosResponse data) => json.encode(data.toJson());

class OpcionesPermisosResponse {
    dynamic mensaje;
    dynamic codigo;
    dynamic dto;
    List<OpcionesPermisos> lista;

    OpcionesPermisosResponse({
        this.mensaje,
        this.codigo,
        this.dto,
        required this.lista,
    });

    OpcionesPermisosResponse copyWith({
        dynamic mensaje,
        dynamic codigo,
        dynamic dto,
        List<OpcionesPermisos>? lista,
    }) => 
        OpcionesPermisosResponse(
            mensaje: mensaje ?? this.mensaje,
            codigo: codigo ?? this.codigo,
            dto: dto ?? this.dto,
            lista: lista ?? this.lista,
        );

    factory OpcionesPermisosResponse.fromJson(Map<String, dynamic> json) => OpcionesPermisosResponse(
        mensaje: json["mensaje"],
        codigo: json["codigo"],
        dto: json["dto"],
        lista: List<OpcionesPermisos>.from(json["lista"].map((x) => OpcionesPermisos.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "codigo": codigo,
        "dto": dto,
        "lista": List<dynamic>.from(lista.map((x) => x.toJson())),
    };
}

class OpcionesPermisos {
    OpcionesPermisosId id;
    Rol idrol;
    Recursos? recursos;
    int? idopcionpadre;
    String? nombre;
    bool activo;
    bool mostar;
    bool crear;
    bool editar;
    bool eliminar;

    OpcionesPermisos({
        required this.id,
        required this.idrol,
        this.recursos,
        this.idopcionpadre,
        this.nombre,
        required this.activo,
        required this.mostar,
        required this.crear,
        required this.editar,
        required this.eliminar,
    });

    OpcionesPermisos copyWith({
        OpcionesPermisosId? id,
        Rol? idrol,
        Recursos? recursos,
        int? idopcionpadre,
        String? nombre,
        bool? activo,
        bool? mostar,
        bool? crear,
        bool? editar,
        bool? eliminar,
    }) => 
        OpcionesPermisos(
            id: id ?? this.id,
            idrol: idrol ?? this.idrol,
            recursos: recursos ?? this.recursos,
            idopcionpadre: idopcionpadre ?? this.idopcionpadre,
            nombre: nombre ?? this.nombre,
            activo: activo ?? this.activo,
            mostar: mostar ?? this.mostar,
            crear: crear ?? this.crear,
            editar: editar ?? this.editar,
            eliminar: eliminar ?? this.eliminar,
        );

    factory OpcionesPermisos.fromJson(Map<String, dynamic> json) => OpcionesPermisos(
        id: OpcionesPermisosId.fromJson(json["id"]),
        idrol: Rol.fromJson(json["idrol"]),
        recursos: json["recursos"] == null ? null : Recursos.fromJson(json["recursos"]),
        idopcionpadre: json["idopcionpadre"] == null ? null : json["idopcionpadre"],
        nombre: json["nombre"] == null ? null : json["nombre"],
        activo: json["activo"],
        mostar: json["mostar"],
        crear: json["crear"],
        editar: json["editar"],
        eliminar: json["eliminar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id.toJson(),
        "idrol": idrol.toJson(),
        "recursos": recursos == null ? null : recursos!.toJson(),
        "idopcionpadre": idopcionpadre,
        "nombre": nombre,
        "activo": activo,
        "mostar": mostar,
        "crear": crear,
        "editar": editar,
        "eliminar": eliminar,
    };

    OpcionesPermisos clone() => OpcionesPermisos(
      id: id,
      idrol: idrol,
      recursos: recursos,
      idopcionpadre: idopcionpadre,
      nombre: nombre,
      activo: activo,
      mostar: mostar,
      crear: crear,
      editar: editar,
      eliminar: eliminar,
    );
}

class OpcionesPermisosId {
    int idrol;
    int idopcion;

    OpcionesPermisosId({
        required this.idrol,
        required this.idopcion,
    });

    OpcionesPermisosId copyWith({
        int? idrol,
        int? idopcion,
    }) => 
        OpcionesPermisosId(
            idrol: idrol ?? this.idrol,
            idopcion: idopcion ?? this.idopcion,
        );

    factory OpcionesPermisosId.fromJson(Map<String, dynamic> json) => OpcionesPermisosId(
        idrol: json["idrol"],
        idopcion: json["idopcion"],
    );

    Map<String, dynamic> toJson() => {
        "idrol": idrol,
        "idopcion": idopcion,
    };

    OpcionesPermisosId clone() => OpcionesPermisosId(
      idrol: idrol,
      idopcion: idopcion,
    );
}


final opcionesPermisosDefault = OpcionesPermisos(
      id: OpcionesPermisosId(idrol: 0, idopcion: 0).clone(),
      idrol: rolDefault.clone(),
      recursos: recursoDefault.clone().copyWith(id: recursoDefault.clone().id.copyWith(idmodulo: null, idrecurso: null)),
      idopcionpadre: 0,
      nombre: null,
      activo: false,
      mostar: false,
      crear: false,
      editar: false,
      eliminar: false,
    );