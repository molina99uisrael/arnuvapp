
import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/autenticacion/infraestructura/infrastructure.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

class UsuarioRolDataSourceImpl extends UsuarioRolDataSource with ArnuvServicios {
  @override
  Future<UsuarioRol> crear(UsuarioRol usuariorol) async {
    try {
      final data = UsuarioRolMapper.entityToJsonData(usuariorol);
      final response = await postServicio('/usuario-rol/crear', data: data);
      var resp = UsuarioRol.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw AutenticacionException(e.message);
    }
  }

  @override
  Future<UsuarioRol> editar(UsuarioRol usuariorol) async {
    try {
      final data = UsuarioRolMapper.entityToJsonData(usuariorol);
      final response = await putServicio('/usuario-rol/actualizar', data: data );
      var resp = UsuarioRol.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw AutenticacionException(e.message);
    }
  }

  @override
  Future<bool> eliminar(UsuarioRol usuariorol) {
    // TODO: implement eliminar
    throw UnimplementedError();
  }

  @override
  Future<List<UsuarioRol>> listar(int limit, int page) async {
    try {
      final response = await getServicio('/usuario-rol/listar');
      var resp = UsuarioRolMapper.listaJsonToList(response.data["lista"]);
      return resp;
    } on SystemException catch (e) {
      throw AutenticacionException(e.message);
    }
  }
  
  @override
  Future<List<UsuarioRol>> listarPorRol(int limit, int page, int idrol) async {
    try {
      final response = await getServicio('/usuario-rol/buscar/$idrol');
      var resp = UsuarioRolMapper.listaJsonToList(response.data["lista"]);
      return resp;
    } on SystemException catch (e) {
      throw AutenticacionException(e.message);
    }
  }
  
}
