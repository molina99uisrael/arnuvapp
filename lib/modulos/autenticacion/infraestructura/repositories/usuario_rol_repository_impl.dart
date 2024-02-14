

import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';

import '../infrastructure.dart';


class UsuarioRolRepositoryImpl extends UsuarioRolRepository {

  final UsuarioRolDataSource dataSource;

  UsuarioRolRepositoryImpl({
    UsuarioRolDataSource? dataSource
  }) : dataSource = dataSource ?? UsuarioRolDataSourceImpl();
  
  @override
  Future<UsuarioRol> crear(UsuarioRol usuariorol) {
    return dataSource.crear(usuariorol);
  }
  
  @override
  Future<UsuarioRol> editar(UsuarioRol usuariorol) {
    return dataSource.editar(usuariorol);
  }
  
  @override
  Future<bool> eliminar(UsuarioRol usuariorol) {
    return dataSource.eliminar(usuariorol);
  }
  
  @override
  Future<List<UsuarioRol>> listar(int limit, int page) {
    return dataSource.listar(limit, page);
  }
  
  @override
  Future<List<UsuarioRol>> listarPorRol(int limit, int page, int idrol) {
    return dataSource.listarPorRol(limit, page, idrol);
  }

}