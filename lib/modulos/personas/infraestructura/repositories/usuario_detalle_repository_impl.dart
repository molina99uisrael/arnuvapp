


import 'package:arnuvapp/modulos/personas/domain/domain.dart';
import '../infraestructure.dart';


class UsuarioDetalleRepositoryImpl extends UsuarioDetalleRepository {

  final UsuarioDetalleDataSource dataSource;

  UsuarioDetalleRepositoryImpl({
    UsuarioDetalleDataSource? dataSource
  }) : dataSource = dataSource ?? UsuarioDetalleDataSourceImpl();
  
  @override
  Future<UsuarioDetalle> crear(UsuarioDetalle usuario) {
    return dataSource.crear(usuario);
  }
  
  @override
  Future<UsuarioDetalle> editar(UsuarioDetalle usuario) {
    return dataSource.editar(usuario);
  }
  
  @override
  Future<bool> eliminar(UsuarioDetalle usuario) {
    return dataSource.eliminar(usuario);
  }
  
  @override
  Future<List<UsuarioDetalle>> listar(int limit, int page) {
    return dataSource.listar(limit, page);
  }
  
  @override
  Future<UsuarioDetalle> buscarPorEmail(String email) {
    return dataSource.buscarPorEmail(email);
  }
  
  @override
  Future<bool> guardarUsuarioUnificado(UsuarioUnificado request) {
    return dataSource.guardarUsuarioUnificado(request);
  }

}