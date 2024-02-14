
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/infraestructura/infraestructure.dart';
import 'package:arnuvapp/modulos/shared/infrastructure/errors/system_errors.dart';

class RecursosMapper {

  static List<Recursos> listaJsonToList( List<dynamic> ljson ) {
    try {
      var lresult = ljson.map((e) => mapJsonToEntity(e));
      return List<Recursos>.from(lresult);
    } catch (e) {
      throw SystemException( e.toString());
    }
  }

  static Recursos mapJsonToEntity(Map<String, dynamic> json) => Recursos(
      id: RecursosId.fromJson(json["id"]),
      idmodulo: ModulosMapper.mapJsonToEntity(json["idmodulo"]),
      nombre: json["nombre"],
      ruta: json["ruta"] == null ? "" : json["ruta"],
    );
  
  static Map<String, dynamic> entityToJsonData(Recursos obj) {
    var mapa = <String, dynamic>{};        
        mapa.addAll({"idrecurso": obj.id.idrecurso});
        mapa.addAll({"idmodulo": obj.id.idmodulo});
        mapa.addAll({"nombre": obj.nombre});
        mapa.addAll({"ruta": obj.ruta});
        return mapa;
  } 

}

