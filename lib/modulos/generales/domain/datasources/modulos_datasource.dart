
import 'package:arnuvapp/modulos/generales/domain/domain.dart';

abstract class ModulosDataSource {

  Future<List<Modulos>> listar( int limit, int page );

  Future<Modulos> crear( Modulos modulo );

  Future<Modulos> editar( Modulos modulo );

  Future<bool> eliminar( Modulos modulo );

}

