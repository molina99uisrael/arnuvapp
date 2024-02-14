


import 'package:arnuvapp/modulos/personas/domain/domain.dart';
import 'package:arnuvapp/modulos/personas/infraestructura/infraestructure.dart';

class UsuarioUnificadoMapper {

  
  static Map<String, dynamic> entityToJsonData(UsuarioUnificado obj) {
    if (obj.email.isEmpty) {
      throw PersonaException("Email no enviado");
    }
    var mapa = <String, dynamic>{};
        mapa.addAll({"nombres": obj.nombres });
        mapa.addAll({"apellidos": obj.apellidos });
        mapa.addAll({"idcatalogoidentificacion": obj.idcatalogoidentificacion });
        mapa.addAll({"iddetalleidentificacion": obj.iddetalleidentificacion });
        mapa.addAll({"identificacion": obj.identificacion });
        mapa.addAll({"celular": obj.celular });
        mapa.addAll({"email": obj.email });
        mapa.addAll({"username": obj.username });
        mapa.addAll({"password": obj.password });
        mapa.addAll({"idrol": obj.idrol });
    return mapa;
  } 

}

