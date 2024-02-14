


import 'package:arnuvapp/modulos/personas/domain/domain.dart';
import 'package:arnuvapp/modulos/personas/infraestructura/infraestructure.dart';
import 'package:arnuvapp/modulos/shared/infrastructure/errors/system_errors.dart';

class UsuarioDetalleMapper {

  static List<UsuarioDetalle> listEntityJsonToList( List<dynamic> ljson ) {
    try {
      var lresult = ljson.map((e) => mapJsonToEntity(e));
      return List<UsuarioDetalle>.from(lresult);
    } catch (e) {
      throw SystemException( e.toString());
    }
  }

  static UsuarioDetalle mapJsonToEntity(Map<String, dynamic> json) => UsuarioDetalle(
        idusuario: json["idusuario"] == null ? 0 : json["idusuario"],
        idpersona: PersonaDetalleMapper.personaJsonToEntity(json["idpersona"]),
        idusuarioing: json["idusuarioing"],
        idusuariomod: json["idusuariomod"],
        idusuarioaprobacion: json["idusuarioaprobacion"],
        fechaingreso: json["fechaingreso"] == null? null : DateTime.tryParse(json["fechaingreso"]),
        fechamodificacion: json["fechamodificacion"] == null? null : DateTime.tryParse(json["fechamodificacion"]),
        fechaaprobacion: json["fechaaprobacion"] == null? null : DateTime.tryParse(json["fechaaprobacion"]),
        estado: json["estado"],
        username: json["username"],
        password: json["password"],
        cambiopassword: json["cambiopassword"],
        observacion: json["observacion"],
    );
  
  static Map<String, dynamic> entityToJsonData(UsuarioDetalle usuario) {
    var mapa = <String, dynamic>{};
        mapa.addAll({"idusuario": usuario.idusuario });
        mapa.addAll({"idpersona": usuario.idpersona.id });
        mapa.addAll({"idusuarioing": usuario.idusuarioing });
        mapa.addAll({"idusuariomod": usuario.idusuariomod });
        mapa.addAll({"idusuarioaprobacion": usuario.idusuarioaprobacion });
        mapa.addAll({"fechaingreso": usuario.fechaingreso!.toIso8601String() });
        mapa.addAll({"fechamodificacion": usuario.fechamodificacion!.toIso8601String() });
        mapa.addAll({"fechaaprobacion": usuario.fechaaprobacion!.toIso8601String() });
        mapa.addAll({"estado": usuario.estado });
        mapa.addAll({"username": usuario.username });
        mapa.addAll({"password": usuario.password });
        mapa.addAll({"cambiopassword": usuario.cambiopassword });
        mapa.addAll({"observacion": usuario.observacion });
    return mapa;
  } 

}

