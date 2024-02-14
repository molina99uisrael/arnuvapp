
import 'package:arnuvapp/modulos/generales/domain/domain.dart';

abstract class RecursosDataSource {

  Future<List<Recursos>> listar( int limit, int page );

  Future<Recursos> crear( Recursos recursos );

  Future<Recursos> editar( Recursos recursos );

  Future<bool> eliminar( Recursos recursos );

  Future<List<Recursos>> listarByIdModulo( int limit, int page, int idmodulo );

}

