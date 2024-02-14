// To parse this JSON data, do
//
//     final usuarioUnificado = usuarioUnificadoFromJson(jsonString);

import 'dart:convert';

UsuarioUnificado usuarioUnificadoFromJson(String str) => UsuarioUnificado.fromJson(json.decode(str));

String usuarioUnificadoToJson(UsuarioUnificado data) => json.encode(data.toJson());

class UsuarioUnificado {
    String nombres;
    String apellidos;
    int idcatalogoidentificacion;
    String iddetalleidentificacion;
    String identificacion;
    String celular;
    String email;
    String username;
    String password;
    int idrol;

    UsuarioUnificado({
        required this.nombres,
        required this.apellidos,
        required this.idcatalogoidentificacion,
        required this.iddetalleidentificacion,
        required this.identificacion,
        required this.celular,
        required this.email,
        required this.username,
        required this.password,
        required this.idrol,
    });

    UsuarioUnificado copyWith({
        String? nombres,
        String? apellidos,
        int? idcatalogoidentificacion,
        String? iddetalleidentificacion,
        String? identificacion,
        String? celular,
        String? email,
        String? username,
        String? password,
        int? idrol,
    }) => 
        UsuarioUnificado(
            nombres: nombres ?? this.nombres,
            apellidos: apellidos ?? this.apellidos,
            idcatalogoidentificacion: idcatalogoidentificacion ?? this.idcatalogoidentificacion,
            iddetalleidentificacion: iddetalleidentificacion ?? this.iddetalleidentificacion,
            identificacion: identificacion ?? this.identificacion,
            celular: celular ?? this.celular,
            email: email ?? this.email,
            username: username ?? this.username,
            password: password ?? this.password,
            idrol: idrol ?? this.idrol,
        );

    factory UsuarioUnificado.fromJson(Map<String, dynamic> json) => UsuarioUnificado(
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        idcatalogoidentificacion: json["idcatalogoidentificacion"],
        iddetalleidentificacion: json["iddetalleidentificacion"],
        identificacion: json["identificacion"],
        celular: json["celular"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        idrol: json["idrol"],
    );

    Map<String, dynamic> toJson() => {
        "nombres": nombres,
        "apellidos": apellidos,
        "idcatalogoidentificacion": idcatalogoidentificacion,
        "iddetalleidentificacion": iddetalleidentificacion,
        "identificacion": identificacion,
        "celular": celular,
        "email": email,
        "username": username,
        "password": password,
        "idrol": idrol,
    };

    UsuarioUnificado clone() => UsuarioUnificado(
      nombres: nombres, 
      apellidos: apellidos, 
      idcatalogoidentificacion: idcatalogoidentificacion, 
      iddetalleidentificacion: iddetalleidentificacion, 
      identificacion: identificacion, 
      celular: celular, 
      email: email, 
      username: username, 
      password: password, 
      idrol: idrol
    );
}


final usuarioUnificadoDefault = UsuarioUnificado(
      nombres: "",
      apellidos: "",
      idcatalogoidentificacion: 0,
      iddetalleidentificacion: "",
      identificacion: "",
      celular: "",
      email: "",
      username: "",
      password: "",
      idrol: 0
    );