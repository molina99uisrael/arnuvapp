
import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';

abstract class RolDataSource {

  Future<List<Rol>> listar( int limit, int page );

  Future<Rol> crear( Rol rol );

  Future<Rol> editar( Rol rol );

  Future<bool> eliminar( Rol rol );

}

