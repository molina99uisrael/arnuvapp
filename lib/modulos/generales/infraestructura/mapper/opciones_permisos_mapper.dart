

import 'package:arnuvapp/modulos/autenticacion/infraestructura/mappers/rol_mapper.dart';
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/infraestructura/infraestructure.dart';
import 'package:arnuvapp/modulos/shared/infrastructure/errors/system_errors.dart';

class OpcionesPermisosMapper {

  static List<OpcionesPermisos> listaJsonToList( List<dynamic> ljson ) {
    try {
      var lresult = ljson.map((e) => mapJsonToEntity(e));
      return List<OpcionesPermisos>.from(lresult);
    } catch (e) {
      throw SystemException( e.toString());
    }
  }

  static OpcionesPermisos mapJsonToEntity(Map<String, dynamic> json) => OpcionesPermisos(
      id: OpcionesPermisosId.fromJson(json["id"]),
      idrol: RolMapper.mapJsonToEntity(json["idrol"]),
      recursos: json["recursos"] == null ? null : RecursosMapper.mapJsonToEntity(json["recursos"]),
      idopcionpadre: json["idopcionpadre"] == null ? null : json["idopcionpadre"],
      nombre: json["nombre"] == null ? null : json["nombre"],
      activo: json["activo"],
      mostar: json["mostar"],
      crear: json["crear"],
      editar: json["editar"],
      eliminar: json["eliminar"],
    );
  
  static Map<String, dynamic> entityToJsonData(OpcionesPermisos obj) {
    var mapa = <String, dynamic>{};
        mapa.addAll({"idrol": obj.id.idrol});
        mapa.addAll({"idopcion": obj.id.idopcion});
        mapa.addAll({"idrecurso": obj.recursos?.id.idrecurso});
        mapa.addAll({"idmodulo": obj.recursos?.id.idmodulo});
        mapa.addAll({"idopcionpadre": obj.idopcionpadre == 0 ? null : obj.idopcionpadre});
        mapa.addAll({"nombre": obj.nombre == "" ? null : obj.nombre});
        mapa.addAll({"activo": obj.activo});
        mapa.addAll({"mostar": obj.mostar});
        mapa.addAll({"crear": obj.crear});
        mapa.addAll({"editar": obj.editar});
        mapa.addAll({"eliminar": obj.eliminar});
    return mapa;
  } 

}

