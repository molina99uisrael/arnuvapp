
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/shared/infrastructure/errors/system_errors.dart';

class ModulosMapper {

  static List<Modulos> listaJsonToList( List<dynamic> ljson ) {
    try {
      var lresult = ljson.map((e) => mapJsonToEntity(e));
      return List<Modulos>.from(lresult);
    } catch (e) {
      throw SystemException( e.toString());
    }
  }

  static Modulos mapJsonToEntity(Map<String, dynamic> json) => Modulos(
      id: json["id"],
      nombre: json["nombre"],
      activo: json["activo"],  
    );
  
  static Map<String, dynamic> entityToJsonData(Modulos persona) {
    var mapa = <String, dynamic>{};
        mapa.addAll({"id": persona.id} );
        mapa.addAll({"nombre": persona.nombre} );
        mapa.addAll({"activo": persona.activo} );
    return mapa;
  } 

}

