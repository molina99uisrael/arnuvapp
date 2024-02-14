import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/infraestructura/infraestructure.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

class OpcionesPermisosDataSourceImpl extends OpcionesPermisosDataSource with ArnuvServicios {
  @override
  Future<OpcionesPermisos> crear(OpcionesPermisos permisos) async {
    try {
      final data = OpcionesPermisosMapper.entityToJsonData(permisos);
      final response = await postServicio('/opciones-permiso/crear', data: data);
      var resp = OpcionesPermisos.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw GeneralesException(e.message);
    }
  }

  @override
  Future<OpcionesPermisos> editar(OpcionesPermisos permisos) async {
    try {
      final data = OpcionesPermisosMapper.entityToJsonData(permisos);
      final response = await putServicio('/opciones-permiso/actualizar', data: data );
      var resp = OpcionesPermisos.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw GeneralesException(e.message);
    }
  }

  @override
  Future<bool> eliminar(OpcionesPermisos permisos) {
    // TODO: implement eliminar
    throw UnimplementedError();
  }

  @override
  Future<List<OpcionesPermisos>> listar(int limit, int page) async {
    try {
      final response = await getServicio('/opciones-permiso/listar');
      var resp = OpcionesPermisosMapper.listaJsonToList(response.data["lista"]);
      return resp;
    } on SystemException catch (e) {
      throw GeneralesException(e.message);
    }
  }

  @override
  Future<List<OpcionesPermisos>> listarByIdRol(int idrol) async {
    try {
      final response = await getServicio('/opciones-permiso/buscaporrol/$idrol');
      var resp = OpcionesPermisosMapper.listaJsonToList(response.data["lista"]);
      return resp;
    } on SystemException catch (e) {
      throw GeneralesException(e.message);
    }
  }
  
}
