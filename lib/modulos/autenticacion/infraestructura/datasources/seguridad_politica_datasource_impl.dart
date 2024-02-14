import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/autenticacion/infraestructura/infrastructure.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

class SeguridadPoliticaDataSourceImpl extends SeguridadPoliticaDataSource with ArnuvServicios {
  
  @override
  Future<SeguridadPolitica> crear(SeguridadPolitica segpolitica) async {
    try {
      final data = SeguridadPoliticaMapper.entityToJsonData(segpolitica);
      final response = await postServicio('/seguridad-politica/crear', data: data);
      var resp = SeguridadPolitica.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw AutenticacionException(e.message);
    }
  }

  @override
  Future<SeguridadPolitica> editar(SeguridadPolitica segpolitica) async {
    try {
      final data = SeguridadPoliticaMapper.entityToJsonData(segpolitica);
      final response = await putServicio('/seguridad-politica/actualizar', data: data );
      var resp = SeguridadPolitica.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw AutenticacionException(e.message);
    }
  }

  @override
  Future<bool> eliminar(SeguridadPolitica segpolitica) {
    // TODO: implement eliminar
    throw UnimplementedError();
  }

  @override
  Future<List<SeguridadPolitica>> listar(int limit, int page) async {
     try {
      final response = await getServicio('/seguridad-politica/listar');
      var resp = SeguridadPoliticaMapper.listaJsonToList(response.data["lista"]);
      return resp;
    } on SystemException catch (e) {
      throw AutenticacionException(e.message);
    }
  }
  
}
