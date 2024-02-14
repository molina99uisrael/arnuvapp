
import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/shared/infrastructure/errors/system_errors.dart';

class RolMapper {

  static List<Rol> listaJsonToList( List<dynamic> ljson ) {
    try {
      var lresult = ljson.map((e) => mapJsonToEntity(e));
      return List<Rol>.from(lresult);
    } catch (e) {
      throw SystemException( e.toString());
    }
  }

  static Rol mapJsonToEntity(Map<String, dynamic> json) => Rol(
      id: json["id"],
      idpolitica: SeguridadPolitica.fromJson(json["idpolitica"]),
      nombre: json["nombre"],
      activo: json["activo"], 
    );
  
  static Map<String, dynamic> entityToJsonData(Rol obj) {
    var mapa = <String, dynamic>{};
        mapa.addAll({"id": obj.id} );
        mapa.addAll({"idpolitica": obj.idpolitica} );
        mapa.addAll({"nombre": obj.nombre} );
        mapa.addAll({"activo": obj.activo} );
    return mapa;
  } 

}

