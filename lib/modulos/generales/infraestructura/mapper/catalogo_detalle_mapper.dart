
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/shared/infrastructure/errors/system_errors.dart';

class CatalogoDetalleMapper {

  static List<CatalogoDetalle> listaJsonToList( List<dynamic> ljson ) {
    try {
      var lresult = ljson.map((e) => mapJsonToEntity(e));
      return List<CatalogoDetalle>.from(lresult);
    } catch (e) {
      throw SystemException( e.toString());
    }
  }

  static CatalogoDetalle mapJsonToEntity(Map<String, dynamic> json) => CatalogoDetalle(
      id: Id.fromJson(json["id"]),
      nombre: json["nombre"],
      activo: json["activo"],
    );
  
  static Map<String, dynamic> entityToJsonData(CatalogoDetalle persona) {
    var mapa = <String, dynamic>{};
        mapa.addAll({"id": persona.id.toJson()} );
        mapa.addAll({"nombre": persona.nombre} );
        mapa.addAll({"activo": persona.activo} );
    return mapa;
  } 

}

