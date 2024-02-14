import 'package:arnuvapp/modulos/personas/domain/domain.dart';
import 'package:arnuvapp/modulos/personas/infraestructura/infraestructure.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

class UsuarioDetalleDataSourceImpl extends UsuarioDetalleDataSource with ArnuvServicios {
  
  @override
  Future<List<UsuarioDetalle>> listar(int limit, int page) async {
    try {
      final response = await getServicio('/usuarios/listar');
      var resp = UsuarioDetalleMapper.listEntityJsonToList(response.data["lista"]);
      return resp;
    } on SystemException catch (e) {
      throw PersonaException(e.message);
    }
  }
  
  @override
  Future<UsuarioDetalle> editar(UsuarioDetalle usuario) async {
    try {
      final data = UsuarioDetalleMapper.entityToJsonData(usuario);
      final response = await putServicio('/usuarios/actualizar', data: data );
      var resp = UsuarioDetalle.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw PersonaException(e.message);
    }
  }
  
  @override
  Future<bool> eliminar(UsuarioDetalle usuario) {
    // TODO: implement eliminar
    throw UnimplementedError();
  }
  
  @override
  Future<UsuarioDetalle> crear(UsuarioDetalle usuario) async {
    try {
      final data = UsuarioDetalleMapper.entityToJsonData(usuario);
      final response = await postServicio('/usuarios/crear', data: data);
      var resp = UsuarioDetalle.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw PersonaException(e.message);
    }
  }
  
  @override
  Future<UsuarioDetalle> buscarPorEmail(String email) async {
    try {
      final response = await getServicio('/usuarios/validar/$email');
      var resp = UsuarioDetalleMapper.mapJsonToEntity(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw PersonaException(e.message);
    }
  }
  
  @override
  Future<bool> guardarUsuarioUnificado(UsuarioUnificado request) async {
    try {
      final data = UsuarioUnificadoMapper.entityToJsonData(request);
      final response = await postServicio('/usuarios/crear-persona-usuario', data: data);
      var resp = response.data["codigo"] == "OK" ? true : false;
      return resp;
    } on SystemException catch (e) {
      throw PersonaException(e.message);
    }
  }
  
}
