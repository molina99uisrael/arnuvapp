
import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/autenticacion/infraestructura/infrastructure.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

class RolDataSourceImpl extends RolDataSource with ArnuvServicios {
  @override
  Future<Rol> crear(Rol rol) async {
    try {
      final data = RolMapper.entityToJsonData(rol);
      final response = await postServicio('/roles/crear', data: data);
      var resp = Rol.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw AutenticacionException(e.message);
    }
  }

  @override
  Future<Rol> editar(Rol rol) async {
    try {
      final data = RolMapper.entityToJsonData(rol);
      final response = await putServicio('/roles/actualizar', data: data );
      var resp = Rol.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw AutenticacionException(e.message);
    }
  }

  @override
  Future<bool> eliminar(Rol rol) {
    // TODO: implement eliminar
    throw UnimplementedError();
  }

  @override
  Future<List<Rol>> listar(int limit, int page) async {
    try {
      final response = await getServicio('/roles/listar');
      var resp = RolMapper.listaJsonToList(response.data["lista"]);
      return resp;
    } on SystemException catch (e) {
      throw AutenticacionException(e.message);
    }
  }
  
}
