import 'dart:convert';

SeguridadPoliticaResponse seguridadPoliticaResponseFromJson(String str) => SeguridadPoliticaResponse.fromJson(json.decode(str));

String seguridadPoliticaResponseToJson(SeguridadPoliticaResponse data) => json.encode(data.toJson());

class SeguridadPoliticaResponse {
    dynamic mensaje;
    dynamic codigo;
    dynamic dto;
    List<SeguridadPolitica> lista;

    SeguridadPoliticaResponse({
        this.mensaje,
        this.codigo,
        this.dto,
        required this.lista,
    });

    SeguridadPoliticaResponse copyWith({
        dynamic mensaje,
        dynamic codigo,
        dynamic dto,
        List<SeguridadPolitica>? lista,
    }) => 
        SeguridadPoliticaResponse(
            mensaje: mensaje ?? this.mensaje,
            codigo: codigo ?? this.codigo,
            dto: dto ?? this.dto,
            lista: lista ?? this.lista,
        );

    factory SeguridadPoliticaResponse.fromJson(Map<String, dynamic> json) => SeguridadPoliticaResponse(
        mensaje: json["mensaje"],
        codigo: json["codigo"],
        dto: json["dto"],
        lista: List<SeguridadPolitica>.from(json["lista"].map((x) => SeguridadPolitica.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "codigo": codigo,
        "dto": dto,
        "lista": List<dynamic>.from(lista.map((x) => x.toJson())),
    };
}

class SeguridadPolitica {
    int id;
    int longitud;
    int intentos;
    int numeros;
    int especiales;
    int minusculas;
    int mayusculas;
    int tiemporegeraciontoken;

    SeguridadPolitica({
        required this.id,
        required this.longitud,
        required this.intentos,
        required this.numeros,
        required this.especiales,
        required this.minusculas,
        required this.mayusculas,
        required this.tiemporegeraciontoken,
    });

    SeguridadPolitica copyWith({
        int? id,
        int? longitud,
        int? intentos,
        int? numeros,
        int? especiales,
        int? minusculas,
        int? mayusculas,
        int? tiemporegeraciontoken,
    }) => 
        SeguridadPolitica(
            id: id ?? this.id,
            longitud: longitud ?? this.longitud,
            intentos: intentos ?? this.intentos,
            numeros: numeros ?? this.numeros,
            especiales: especiales ?? this.especiales,
            minusculas: minusculas ?? this.minusculas,
            mayusculas: mayusculas ?? this.mayusculas,
            tiemporegeraciontoken: tiemporegeraciontoken ?? this.tiemporegeraciontoken,
        );

    factory SeguridadPolitica.fromJson(Map<String, dynamic> json) => SeguridadPolitica(
        id: json["id"],
        longitud: json["longitud"],
        intentos: json["intentos"],
        numeros: json["numeros"],
        especiales: json["especiales"],
        minusculas: json["minusculas"],
        mayusculas: json["mayusculas"],
        tiemporegeraciontoken: json["tiemporegeraciontoken"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "longitud": longitud,
        "intentos": intentos,
        "numeros": numeros,
        "especiales": especiales,
        "minusculas": minusculas,
        "mayusculas": mayusculas,
        "tiemporegeraciontoken": tiemporegeraciontoken,
    };
    
    SeguridadPolitica clone() => SeguridadPolitica(
      id: id,
      longitud: longitud,
      intentos: intentos,
      numeros: numeros,
      especiales: especiales,
      minusculas: minusculas,
      mayusculas: mayusculas,
      tiemporegeraciontoken: tiemporegeraciontoken,
    );
}


final seguridadPoliticaDefault = SeguridadPolitica(
        id: 0,
        longitud: 0,
        intentos: 0,
        numeros: 0,
        especiales: 0,
        minusculas: 0,
        mayusculas: 0,
        tiemporegeraciontoken: 0,
    );