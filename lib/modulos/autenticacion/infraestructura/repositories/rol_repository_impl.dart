

import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';

import '../infrastructure.dart';


class RolRepositoryImpl extends RolRepository {

  final RolDataSource dataSource;

  RolRepositoryImpl({
    RolDataSource? dataSource
  }) : dataSource = dataSource ?? RolDataSourceImpl();
  
  @override
  Future<Rol> crear(Rol rol) {
    return dataSource.crear(rol);
  }
  
  @override
  Future<Rol> editar(Rol rol) {
    return dataSource.editar(rol);
  }
  
  @override
  Future<bool> eliminar(Rol rol) {
    return dataSource.eliminar(rol);
  }
  
  @override
  Future<List<Rol>> listar(int limit, int page) {
    return dataSource.listar(limit, page);
  }

}