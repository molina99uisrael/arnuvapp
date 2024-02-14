

import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';

abstract class UsuarioRolRepository {

  Future<List<UsuarioRol>> listar( int limit, int page );

  Future<UsuarioRol> crear( UsuarioRol usuariorol );

  Future<UsuarioRol> editar( UsuarioRol usuariorol );

  Future<bool> eliminar( UsuarioRol usuariorol );

  Future<List<UsuarioRol>> listarPorRol( int limit, int page, int idrol );

}

