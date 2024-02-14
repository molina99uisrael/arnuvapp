
import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/personas/infraestructura/infraestructure.dart';
import 'package:arnuvapp/modulos/shared/infrastructure/errors/system_errors.dart';

class UsuarioRolMapper {

  static List<UsuarioRol> listaJsonToList( List<dynamic> ljson ) {
    try {
      var lresult = ljson.map((e) => mapJsonToEntity(e));
      return List<UsuarioRol>.from(lresult);
    } catch (e) {
      throw SystemException( e.toString());
    }
  }

  static UsuarioRol mapJsonToEntity(Map<String, dynamic> json) => UsuarioRol(
      id: UsuarioRolId.fromJson(json["id"]),
      idrol: Rol.fromJson(json["idrol"]),
      idusuario: UsuarioDetalleMapper.mapJsonToEntity(json["idusuario"]),
      idususarioing: json["idususarioing"],
      idususariomod: json["idususariomod"],
      fechaingreso: DateTime.parse(json["fechaingreso"]),
      fechamodificacion: json["fechamodificacion"],
       
    );
  
  static Map<String, dynamic> entityToJsonData(UsuarioRol obj) {
    var mapa = <String, dynamic>{};        
        mapa.addAll({"id": obj.id });
        mapa.addAll({"idrol": obj.idrol.id });
        mapa.addAll({"idusuario": obj.idusuario.idusuario });
        mapa.addAll({"idususarioing": obj.idususarioing });
        mapa.addAll({"idususariomod": obj.idususariomod });
        mapa.addAll({"fechaingreso": obj.fechaingreso.toIso8601String() });
        mapa.addAll({"fechamodificacion": obj.fechamodificacion.toIso8601String() });
    return mapa;
  } 

}

