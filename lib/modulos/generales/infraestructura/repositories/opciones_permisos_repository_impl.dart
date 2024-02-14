



import 'package:arnuvapp/modulos/generales/domain/domain.dart';

import '../infraestructure.dart';


class OpcionesPermisosRepositoryImpl extends OpcionesPermisosRepository {

  final OpcionesPermisosDataSource dataSource;

  OpcionesPermisosRepositoryImpl({
    OpcionesPermisosDataSource? dataSource
  }) : dataSource = dataSource ?? OpcionesPermisosDataSourceImpl();
  
  @override
  Future<OpcionesPermisos> crear(OpcionesPermisos permisos) {
    return dataSource.crear(permisos);
  }
  
  @override
  Future<OpcionesPermisos> editar(OpcionesPermisos permisos) {
    return dataSource.editar(permisos);
  }
  
  @override
  Future<bool> eliminar(OpcionesPermisos permisos) {
    return dataSource.eliminar(permisos);
  }
  
  @override
  Future<List<OpcionesPermisos>> listar(int limit, int page) {
    return dataSource.listar(limit, page);
  }
  
  @override
  Future<List<OpcionesPermisos>> listarByIdRol(int idrol) {
    return dataSource.listarByIdRol(idrol);
  }

}