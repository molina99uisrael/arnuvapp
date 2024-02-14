import 'dart:convert';

CatalogoResponse catalogoResponseFromJson(String str) => CatalogoResponse.fromJson(json.decode(str));

String catalogoResponseToJson(CatalogoResponse data) => json.encode(data.toJson());

class CatalogoResponse {
    dynamic mensaje;
    dynamic codigo;
    dynamic dto;
    List<Catalogo> lista;

    CatalogoResponse({
        this.mensaje,
        this.codigo,
        this.dto,
        required this.lista,
    });

    CatalogoResponse copyWith({
        dynamic mensaje,
        dynamic codigo,
        dynamic dto,
        List<Catalogo>? lista,
    }) => 
        CatalogoResponse(
            mensaje: mensaje ?? this.mensaje,
            codigo: codigo ?? this.codigo,
            dto: dto ?? this.dto,
            lista: lista ?? this.lista,
        );

    factory CatalogoResponse.fromJson(Map<String, dynamic> json) => CatalogoResponse(
        mensaje: json["mensaje"],
        codigo: json["codigo"],
        dto: json["dto"],
        lista: List<Catalogo>.from(json["lista"].map((x) => Catalogo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "codigo": codigo,
        "dto": dto,
        "lista": List<dynamic>.from(lista.map((x) => x.toJson())),
    };
}

class Catalogo {
    int id;
    String nombre;
    bool activo;

    Catalogo({
        required this.id,
        required this.nombre,
        required this.activo,
    });

    Catalogo copyWith({
        int? id,
        String? nombre,
        bool? activo,
    }) => 
        Catalogo(
            id: id ?? this.id,
            nombre: nombre ?? this.nombre,
            activo: activo ?? this.activo,
        );

    factory Catalogo.fromJson(Map<String, dynamic> json) => Catalogo(
        id: json["id"],
        nombre: json["nombre"],
        activo: json["activo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "activo": activo,
    };

    Catalogo clone() => Catalogo(
      id: id,
      nombre: nombre,
      activo: activo,
    );
}

final catalogoDefault = Catalogo(
        id: 0,
        nombre: "",
        activo: false
    );