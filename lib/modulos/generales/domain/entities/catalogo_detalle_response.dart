import 'dart:convert';

CatalogoDetalleResponse catalogoDetalleResponseFromJson(String str) => CatalogoDetalleResponse.fromJson(json.decode(str));

String catalogoDetalleResponseToJson(CatalogoDetalleResponse data) => json.encode(data.toJson());

class CatalogoDetalleResponse {
    dynamic mensaje;
    dynamic codigo;
    dynamic dto;
    List<CatalogoDetalle> lista;

    CatalogoDetalleResponse({
        this.mensaje,
        this.codigo,
        this.dto,
        required this.lista,
    });

    CatalogoDetalleResponse copyWith({
        dynamic mensaje,
        dynamic codigo,
        dynamic dto,
        List<CatalogoDetalle>? lista,
    }) => 
        CatalogoDetalleResponse(
            mensaje: mensaje ?? this.mensaje,
            codigo: codigo ?? this.codigo,
            dto: dto ?? this.dto,
            lista: lista ?? this.lista,
        );

    factory CatalogoDetalleResponse.fromJson(Map<String, dynamic> json) => CatalogoDetalleResponse(
        mensaje: json["mensaje"],
        codigo: json["codigo"],
        dto: json["dto"],
        lista: List<CatalogoDetalle>.from(json["lista"].map((x) => CatalogoDetalle.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "codigo": codigo,
        "dto": dto,
        "lista": List<dynamic>.from(lista.map((x) => x.toJson())),
    };
}

class CatalogoDetalle {
    Id id;
    String nombre;
    bool activo;

    CatalogoDetalle({
        required this.id,
        required this.nombre,
        required this.activo,
    });

    CatalogoDetalle copyWith({
        Id? id,
        String? nombre,
        bool? activo,
    }) => 
        CatalogoDetalle(
            id: id ?? this.id,
            nombre: nombre ?? this.nombre,
            activo: activo ?? this.activo,
        );

    factory CatalogoDetalle.fromJson(Map<String, dynamic> json) => CatalogoDetalle(
        id: Id.fromJson(json["id"]),
        nombre: json["nombre"],
        activo: json["activo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id.toJson(),
        "nombre": nombre,
        "activo": activo,
    };

    CatalogoDetalle clone() => CatalogoDetalle(
      id: id,
      nombre: nombre,
      activo: activo,
    );
}

class Id {
    int idcatalogo;
    String iddetalle;

    Id({
        required this.idcatalogo,
        required this.iddetalle,
    });

    Id copyWith({
        int? idcatalogo,
        String? iddetalle,
    }) => 
        Id(
            idcatalogo: idcatalogo ?? this.idcatalogo,
            iddetalle: iddetalle ?? this.iddetalle,
        );

    factory Id.fromJson(Map<String, dynamic> json) => Id(
        idcatalogo: json["idcatalogo"],
        iddetalle: json["iddetalle"],
    );

    Map<String, dynamic> toJson() => {
        "idcatalogo": idcatalogo,
        "iddetalle": iddetalle,
    };

    Id clone() => Id(
      idcatalogo: idcatalogo,
      iddetalle: iddetalle,
    );
}


final catalogoDetalleDefault = CatalogoDetalle(
        id: Id(idcatalogo: 0, iddetalle: "").clone(),
        nombre: "",
        activo: false
    );