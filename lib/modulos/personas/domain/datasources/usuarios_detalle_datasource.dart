import 'package:arnuvapp/modulos/personas/domain/domain.dart';

abstract class UsuarioDetalleDataSource {

  Future<List<UsuarioDetalle>> listar( int limit, int page );
  
  Future<UsuarioDetalle> crear( UsuarioDetalle usuario );

  Future<UsuarioDetalle> editar( UsuarioDetalle usuario );

  Future<bool> eliminar( UsuarioDetalle usuario );

  Future<UsuarioDetalle> buscarPorEmail( String email );

  Future<bool> guardarUsuarioUnificado( UsuarioUnificado request );

}

