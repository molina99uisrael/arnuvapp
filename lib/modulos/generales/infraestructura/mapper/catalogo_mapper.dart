
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/shared/infrastructure/errors/system_errors.dart';

class CatalogoMapper {

  static List<Catalogo> listaJsonToList( List<dynamic> ljson ) {
    try {
      var lresult = ljson.map((e) => mapJsonToEntity(e));
      return List<Catalogo>.from(lresult);
    } catch (e) {
      throw SystemException( e.toString());
    }
  }

  static Catalogo mapJsonToEntity(Map<String, dynamic> json) => Catalogo(
      id: json["id"],
      nombre: json["nombre"],
      activo: json["activo"],  
    );
  
  static Map<String, dynamic> entityToJsonData(Catalogo persona) {
    var mapa = <String, dynamic>{};
        mapa.addAll({"id": persona.id} );
        mapa.addAll({"nombre": persona.nombre} );
        mapa.addAll({"activo": persona.activo} );
    return mapa;
  } 

}

