import 'dart:convert';

import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/personas/domain/domain.dart';

PersonaDetalleResponse personaResponseFromJson(String str) => PersonaDetalleResponse.fromJson(json.decode(str));

String personaResponseToJson(PersonaDetalleResponse data) => json.encode(data.toJson());

class PersonaDetalleResponse {
    dynamic mensaje;
    dynamic codigo;
    dynamic dto;
    List<PersonaDetalle> lista;

    PersonaDetalleResponse({
        this.mensaje,
        this.codigo,
        this.dto,
        required this.lista,
    });

    factory PersonaDetalleResponse.fromJson(Map<String, dynamic> json) => PersonaDetalleResponse(
        mensaje: json["mensaje"],
        codigo: json["codigo"],
        dto: json["dto"],
        lista: List<PersonaDetalle>.from(json["lista"].map((x) => PersonaDetalle.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "codigo": codigo,
        "dto": dto,
        "lista": List<dynamic>.from(lista.map((x) => x.toJson())),
    };
}

class PersonaDetalle {
    int id;
    String? idusuarioing;
    String? idusuariomod;
    String? fechaingreso;
    String? fechamodificacion;
    String nombres;
    String apellidos;
    CatalogoDetalle catalogodetalle;
    String identificacion;
    String celular;
    String email;

    PersonaDetalle({
        required this.id,
        this.idusuarioing,
        this.idusuariomod,
        this.fechaingreso,
        this.fechamodificacion,
        required this.nombres,
        required this.apellidos,
        required this.catalogodetalle,
        required this.identificacion,
        required this.celular,
        required this.email,
    });

    PersonaDetalle copyWith({
        int? id,
        dynamic idusuarioing,
        dynamic idusuariomod,
        dynamic fechaingreso,
        dynamic fechamodificacion,
        String? nombres,
        String? apellidos,
        CatalogoDetalle? catalogodetalle,
        String? identificacion,
        String? celular,
        String? email,
    }) => 
        PersonaDetalle(
            id: id ?? this.id,
            idusuarioing: idusuarioing ?? this.idusuarioing,
            idusuariomod: idusuariomod ?? this.idusuariomod,
            fechaingreso: fechaingreso ?? this.fechaingreso,
            fechamodificacion: fechamodificacion ?? this.fechamodificacion,
            nombres: nombres ?? this.nombres,
            apellidos: apellidos ?? this.apellidos,
            catalogodetalle: catalogodetalle ?? this.catalogodetalle,
            identificacion: identificacion ?? this.identificacion,
            celular: celular ?? this.celular,
            email: email ?? this.email,
        );

    factory PersonaDetalle.fromJson(Map<String, dynamic> json) => PersonaDetalle(
        id: json["id"],
        idusuarioing: json["idusuarioing"],
        idusuariomod: json["idusuariomod"],
        fechaingreso: json["fechaingreso"],
        fechamodificacion: json["fechamodificacion"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        catalogodetalle: CatalogoDetalle.fromJson(json["catalogodetalle"]),
        identificacion: json["identificacion"],
        celular: json["celular"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idusuarioing": idusuarioing,
        "idusuariomod": idusuariomod,
        "fechaingreso": fechaingreso,
        "fechamodificacion": fechamodificacion,
        "nombres": nombres,
        "apellidos": apellidos,
        "catalogodetalle": catalogodetalle.toJson(),
        "identificacion": identificacion,
        "celular": celular,
        "email": email,
    };

    PersonaDetalle clone() => PersonaDetalle(
      id: id,
      idusuarioing: idusuarioing,
      idusuariomod: idusuariomod,
      fechaingreso: fechaingreso,
      fechamodificacion: fechamodificacion,
      nombres: nombres,
      apellidos: apellidos,
      catalogodetalle: catalogodetalle,
      identificacion: identificacion,
      celular: celular,
      email: email,
    );

}


final personaDetalleDefault = PersonaDetalle(
        id: 0,
        idusuarioing: '',
        idusuariomod: '',
        fechaingreso: '',
        fechamodificacion: '',
        nombres: '',
        apellidos: '',
        catalogodetalle: catalogoDetalleDefault.clone(),
        identificacion: '',
        celular: '',
        email: '',
    );