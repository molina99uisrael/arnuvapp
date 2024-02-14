import 'dart:convert';

import 'package:arnuvapp/modulos/personas/domain/domain.dart';

UsuarioDetalleResponse usuarioDetalleResponseFromJson(String str) => UsuarioDetalleResponse.fromJson(json.decode(str));

String usuarioDetalleResponseToJson(UsuarioDetalleResponse data) => json.encode(data.toJson());

class UsuarioDetalleResponse {
    dynamic mensaje;
    dynamic codigo;
    UsuarioDetalle? dto;
    List<UsuarioDetalle> lista;

    UsuarioDetalleResponse({
        this.mensaje,
        this.codigo,
        this.dto,
        required this.lista,
    });

    UsuarioDetalleResponse copyWith({
        dynamic mensaje,
        dynamic codigo,
        dynamic dto,
        List<UsuarioDetalle>? lista,
    }) => 
        UsuarioDetalleResponse(
            mensaje: mensaje ?? this.mensaje,
            codigo: codigo ?? this.codigo,
            dto: dto ?? this.dto,
            lista: lista ?? this.lista,
        );

    factory UsuarioDetalleResponse.fromJson(Map<String, dynamic> json) => UsuarioDetalleResponse(
        mensaje: json["mensaje"],
        codigo: json["codigo"],
        dto: json["dto"],
        lista: List<UsuarioDetalle>.from(json["lista"].map((x) => UsuarioDetalle.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "codigo": codigo,
        "dto": dto,
        "lista": List<dynamic>.from(lista.map((x) => x.toJson())),
    };
}

class UsuarioDetalle {
    int idusuario;
    PersonaDetalle idpersona;
    String? idusuarioing;
    String? idusuariomod;
    String? idusuarioaprobacion;
    DateTime? fechaingreso;
    DateTime? fechamodificacion;
    DateTime? fechaaprobacion;
    bool estado;
    String username;
    String password;
    bool cambiopassword;
    String observacion;

    UsuarioDetalle({
        required this.idusuario,
        required this.idpersona,
        this.idusuarioing,
        this.idusuariomod,
        this.idusuarioaprobacion,
        this.fechaingreso,
        this.fechamodificacion,
        this.fechaaprobacion,
        required this.estado,
        required this.username,
        required this.password,
        required this.cambiopassword,
        required this.observacion,
    });

    UsuarioDetalle copyWith({
        int? idusuario,
        PersonaDetalle? idpersona,
        String? idusuarioing,
        String? idusuariomod,
        String? idusuarioaprobacion,
        DateTime? fechaingreso,
        DateTime? fechamodificacion,
        DateTime? fechaaprobacion,
        bool? estado,
        String? username,
        String? password,
        bool? cambiopassword,
        String? observacion,
    }) => 
        UsuarioDetalle(
            idusuario: idusuario ?? this.idusuario,
            idpersona: idpersona ?? this.idpersona,
            idusuarioing: idusuarioing ?? this.idusuarioing,
            idusuariomod: idusuariomod ?? this.idusuariomod,
            idusuarioaprobacion: idusuarioaprobacion ?? this.idusuarioaprobacion,
            fechaingreso: fechaingreso ?? this.fechaingreso,
            fechamodificacion: fechamodificacion ?? this.fechamodificacion,
            fechaaprobacion: fechaaprobacion ?? this.fechaaprobacion,
            estado: estado ?? this.estado,
            username: username ?? this.username,
            password: password ?? this.password,
            cambiopassword: cambiopassword ?? this.cambiopassword,
            observacion: observacion ?? this.observacion,
        );

    factory UsuarioDetalle.fromJson(Map<String, dynamic> json) => UsuarioDetalle(
        idusuario: json["idusuario"],
        idpersona: PersonaDetalle.fromJson(json["idpersona"]),
        idusuarioing: json["idusuarioing"],
        idusuariomod: json["idusuariomod"],
        idusuarioaprobacion: json["idusuarioaprobacion"],
        fechaingreso: DateTime.tryParse(json["fechaingreso"]),
        fechamodificacion: DateTime.tryParse(json["fechamodificacion"]) ?? DateTime.now(),
        fechaaprobacion: DateTime.tryParse(json["fechaaprobacion"]),
        estado: json["estado"],
        username: json["username"],
        password: json["password"],
        cambiopassword: json["cambiopassword"],
        observacion: json["observacion"],
    );

    Map<String, dynamic> toJson() => {
        "idusuario": idusuario,
        "idpersona": idpersona.toJson(),
        "idusuarioing": idusuarioing,
        "idusuariomod": idusuariomod,
        "idusuarioaprobacion": idusuarioaprobacion,
        "fechaingreso": fechamodificacion,
        "fechamodificacion": fechamodificacion,
        "fechaaprobacion": fechaaprobacion,
        "estado": estado,
        "username": username,
        "password": password,
        "cambiopassword": cambiopassword,
        "observacion": observacion,
    };

    UsuarioDetalle clone() => UsuarioDetalle(
      idusuario: idusuario,
      idpersona: idpersona,
      idusuarioing: idusuarioing,
      idusuariomod: idusuariomod,
      idusuarioaprobacion: idusuarioaprobacion,
      fechaingreso: fechaingreso,
      fechamodificacion: fechamodificacion,
      fechaaprobacion: fechaaprobacion,
      estado: estado,
      username: username,
      password: password,
      cambiopassword: cambiopassword,
      observacion: observacion,
    );
}


final usuarioDetalleDefault = UsuarioDetalle(
          idusuario: 0,
          idpersona: personaDetalleDefault.clone(),
          idusuarioing: null,
          idusuariomod: null,
          idusuarioaprobacion: null,
          fechaingreso: DateTime.now(),
          fechamodificacion: DateTime.now(),
          fechaaprobacion: DateTime.now(),
          estado: true,
          username: "",
          password: "",
          cambiopassword: true,
          observacion: "",
      );