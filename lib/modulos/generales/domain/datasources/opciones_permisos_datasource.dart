
import 'package:arnuvapp/modulos/generales/domain/domain.dart';

abstract class OpcionesPermisosDataSource {

  Future<List<OpcionesPermisos>> listar( int limit, int page);

  Future<List<OpcionesPermisos>> listarByIdRol( int idrol );

  Future<OpcionesPermisos> crear( OpcionesPermisos permisos );

  Future<OpcionesPermisos> editar( OpcionesPermisos permisos );

  Future<bool> eliminar( OpcionesPermisos permisos );

}

