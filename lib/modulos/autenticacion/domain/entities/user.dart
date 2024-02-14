import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    String? mensaje;
    String? codigo;
    User? dto;
    List<dynamic>? lista;

    LoginResponse({
        this.mensaje,
        this.codigo,
        this.dto,
        this.lista,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        mensaje: json["mensaje"],
        codigo: json["codigo"],
        dto: json["dto"] == null ? null : User.fromJson(json["dto"]),
        lista: json["lista"] == null ? [] : List<dynamic>.from(json["lista"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "codigo": codigo,
        "dto": dto?.toJson(),
        "lista": lista == null ? [] : List<dynamic>.from(lista!.map((x) => x)),
    };
}

class User {
    int? idusuario;
    int? idpersona;
    String username;
    String email;
    int? idrol;
    String nrol;

    User({
        this.idusuario,
        this.idpersona,
        required this.username,
        required this.email,
        this.idrol,
        required this.nrol,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        idusuario: json["idusuario"],
        idpersona: json["idpersona"],
        username: json["username"],
        email: json["email"],
        idrol: json["idrol"],
        nrol: json["nrol"],
    );

    Map<String, dynamic> toJson() => {
        "idusuario": idusuario,
        "idpersona": idpersona,
        "username": username,
        "email": email,
        "idrol": idrol,
        "nrol": nrol,
    };
}
