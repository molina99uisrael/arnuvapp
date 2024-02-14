import 'dart:convert';

ModulosResponse modulosResponseFromJson(String str) => ModulosResponse.fromJson(json.decode(str));

String modulosResponseToJson(ModulosResponse data) => json.encode(data.toJson());

class ModulosResponse {
    dynamic mensaje;
    dynamic codigo;
    dynamic dto;
    List<Modulos> lista;

    ModulosResponse({
        this.mensaje,
        this.codigo,
        this.dto,
        required this.lista,
    });

    ModulosResponse copyWith({
        dynamic mensaje,
        dynamic codigo,
        dynamic dto,
        List<Modulos>? lista,
    }) => 
        ModulosResponse(
            mensaje: mensaje ?? this.mensaje,
            codigo: codigo ?? this.codigo,
            dto: dto ?? this.dto,
            lista: lista ?? this.lista,
        );

    factory ModulosResponse.fromJson(Map<String, dynamic> json) => ModulosResponse(
        mensaje: json["mensaje"],
        codigo: json["codigo"],
        dto: json["dto"],
        lista: List<Modulos>.from(json["lista"].map((x) => Modulos.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "codigo": codigo,
        "dto": dto,
        "lista": List<dynamic>.from(lista.map((x) => x.toJson())),
    };
}

class Modulos {
    int id;
    String nombre;
    bool activo;

    Modulos({
        required this.id,
        required this.nombre,
        required this.activo,
    });

    Modulos copyWith({
        int? id,
        String? nombre,
        bool? activo,
    }) => 
        Modulos(
            id: id ?? this.id,
            nombre: nombre ?? this.nombre,
            activo: activo ?? this.activo,
        );

    factory Modulos.fromJson(Map<String, dynamic> json) => Modulos(
        id: json["id"],
        nombre: json["nombre"],
        activo: json["activo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "activo": activo,
    };

    Modulos clone() => Modulos(
      id: id,
      nombre: nombre,
      activo: activo,
    );
}


final modulosDefault = Modulos(
        id: 0,
        nombre: "",
        activo: false
    );