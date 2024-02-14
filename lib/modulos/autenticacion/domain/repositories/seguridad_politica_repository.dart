


import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';

abstract class SeguridadPoliticaRepository {

  Future<List<SeguridadPolitica>> listar( int limit, int page );

  Future<SeguridadPolitica> crear( SeguridadPolitica segpolitica );

  Future<SeguridadPolitica> editar( SeguridadPolitica segpolitica );

  Future<bool> eliminar( SeguridadPolitica segpolitica );
}

