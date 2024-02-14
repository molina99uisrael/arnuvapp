

import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/shared/infrastructure/errors/system_errors.dart';

class SeguridadPoliticaMapper {

  static List<SeguridadPolitica> listaJsonToList( List<dynamic> ljson ) {
    try {
      var lresult = ljson.map((e) => mapJsonToEntity(e));
      return List<SeguridadPolitica>.from(lresult);
    } catch (e) {
      throw SystemException( e.toString());
    }
  }

  static SeguridadPolitica mapJsonToEntity(Map<String, dynamic> json) => SeguridadPolitica(
      id: json["id"],
      longitud: json["longitud"],
      intentos: json["intentos"],
      numeros: json["numeros"],
      especiales: json["especiales"],
      minusculas: json["minusculas"],
      mayusculas: json["mayusculas"],
      tiemporegeraciontoken: json["tiemporegeraciontoken"],
    );
  
  static Map<String, dynamic> entityToJsonData(SeguridadPolitica obj) {
    var mapa = <String, dynamic>{};
        mapa.addAll({"id": obj.id} );
        mapa.addAll({"longitud": obj.longitud} );
        mapa.addAll({"intentos": obj.intentos} );
        mapa.addAll({"numeros": obj.numeros} );
        mapa.addAll({"especiales": obj.especiales} );
        mapa.addAll({"minusculas": obj.minusculas} );
        mapa.addAll({"mayusculas": obj.mayusculas} );
        mapa.addAll({"tiemporegeraciontoken": obj.tiemporegeraciontoken} );
    return mapa;
  } 

}

