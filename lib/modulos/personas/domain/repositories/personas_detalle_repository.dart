
import 'package:arnuvapp/modulos/personas/domain/domain.dart';

abstract class PersonaDetalleRepository {

  Future<List<PersonaDetalle>> listar( int limit, int page );

  Future<PersonaDetalle> crear( PersonaDetalle persona );

  Future<PersonaDetalle> editar( PersonaDetalle persona );

  Future<bool> eliminar( PersonaDetalle persona );

  Future<PersonaDetalle> buscarPorIdentificacion( String identificacion );

}

