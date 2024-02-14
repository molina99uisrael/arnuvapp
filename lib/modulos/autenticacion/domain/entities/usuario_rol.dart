import 'dart:convert';

import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/personas/domain/entities/usuario_detalle_response.dart';


UsuarioRolResponse usuarioRolResponseFromJson(String str) => UsuarioRolResponse.fromJson(json.decode(str));

String usuarioRolResponseToJson(UsuarioRolResponse data) => json.encode(data.toJson());

class UsuarioRolResponse {
    dynamic mensaje;
    dynamic codigo;
    dynamic dto;
    List<UsuarioRol> lista;

    UsuarioRolResponse({
        this.mensaje,
        this.codigo,
        this.dto,
        required this.lista,
    });

    UsuarioRolResponse copyWith({
        dynamic mensaje,
        dynamic codigo,
        dynamic dto,
        List<UsuarioRol>? lista,
    }) => 
        UsuarioRolResponse(
            mensaje: mensaje ?? this.mensaje,
            codigo: codigo ?? this.codigo,
            dto: dto ?? this.dto,
            lista: lista ?? this.lista,
        );

    factory UsuarioRolResponse.fromJson(Map<String, dynamic> json) => UsuarioRolResponse(
        mensaje: json["mensaje"],
        codigo: json["codigo"],
        dto: json["dto"],
        lista: List<UsuarioRol>.from(json["lista"].map((x) => UsuarioRol.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "codigo": codigo,
        "dto": dto,
        "lista": List<dynamic>.from(lista.map((x) => x.toJson())),
    };
}

class UsuarioRol {
    UsuarioRolId id;
    Rol idrol;
    UsuarioDetalle idusuario;
    String idususarioing;
    dynamic idususariomod;
    DateTime fechaingreso;
    dynamic fechamodificacion;

    UsuarioRol({
        required this.id,
        required this.idrol,
        required this.idusuario,
        required this.idususarioing,
        required this.idususariomod,
        required this.fechaingreso,
        required this.fechamodificacion,
    });

    UsuarioRol copyWith({
        UsuarioRolId? id,
        Rol? idrol,
        UsuarioDetalle? idusuario,
        String? idususarioing,
        dynamic idususariomod,
        DateTime? fechaingreso,
        dynamic fechamodificacion,
    }) => 
        UsuarioRol(
            id: id ?? this.id,
            idrol: idrol ?? this.idrol,
            idusuario: idusuario ?? this.idusuario,
            idususarioing: idususarioing ?? this.idususarioing,
            idususariomod: idususariomod ?? this.idususariomod,
            fechaingreso: fechaingreso ?? this.fechaingreso,
            fechamodificacion: fechamodificacion ?? this.fechamodificacion,
        );

    factory UsuarioRol.fromJson(Map<String, dynamic> json) => UsuarioRol(
        id: UsuarioRolId.fromJson(json["id"]),
        idrol: Rol.fromJson(json["idrol"]),
        idusuario: UsuarioDetalle.fromJson(json["idusuario"]),
        idususarioing: json["idususarioing"],
        idususariomod: json["idususariomod"] ?? "",
        fechaingreso: DateTime.parse(json["fechaingreso"]),
        fechamodificacion: json["fechamodificacion"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "id": id.toJson(),
        "idrol": idrol.toJson(),
        "idusuario": idusuario.toJson(),
        "idususarioing": idususarioing,
        "idususariomod": idususariomod,
        "fechaingreso": "${fechaingreso.year.toString().padLeft(4, '0')}-${fechaingreso.month.toString().padLeft(2, '0')}-${fechaingreso.day.toString().padLeft(2, '0')}",
        "fechamodificacion": fechamodificacion,
    };

    UsuarioRol clone() => UsuarioRol(
      id: id,
      idrol: idrol,
      idusuario: idusuario,
      idususarioing: idususarioing,
      idususariomod: idususariomod,
      fechaingreso: fechaingreso,
      fechamodificacion: fechamodificacion,
    );
}

class UsuarioRolId {
    int idrol;
    int idusuario;

    UsuarioRolId({
        required this.idrol,
        required this.idusuario,
    });

    UsuarioRolId copyWith({
        int? idrol,
        int? idusuario,
    }) => 
        UsuarioRolId(
            idrol: idrol ?? this.idrol,
            idusuario: idusuario ?? this.idusuario,
        );

    factory UsuarioRolId.fromJson(Map<String, dynamic> json) => UsuarioRolId(
        idrol: json["idrol"],
        idusuario: json["idusuario"],
    );

    Map<String, dynamic> toJson() => {
        "idrol": idrol,
        "idusuario": idusuario,
    };

    UsuarioRolId clone() => UsuarioRolId(
      idrol: idrol,
      idusuario: idusuario,
    );
}

final usuarioRolDefault = UsuarioRol(
      id: UsuarioRolId(idrol: 0, idusuario: 0).clone(),
      idrol: rolDefault.clone(),
      idusuario: usuarioDetalleDefault.clone(),
      idususarioing: "",
      idususariomod: "",
      fechaingreso: DateTime.now(),
      fechamodificacion: DateTime.now(),
    );