
import 'package:arnuvapp/modulos/generales/domain/domain.dart';

abstract class CatalogoDetalleDataSource {

  Future<List<CatalogoDetalle>> listar( int limit, int page);

  Future<List<CatalogoDetalle>> listarByIdCatalogo( int limit, int page, int idcatalogo );

  Future<CatalogoDetalle> crear( CatalogoDetalle catalogodetalle );

  Future<CatalogoDetalle> editar( CatalogoDetalle catalogodetalle );

  Future<bool> eliminar( CatalogoDetalle catalogodetalle );

}

