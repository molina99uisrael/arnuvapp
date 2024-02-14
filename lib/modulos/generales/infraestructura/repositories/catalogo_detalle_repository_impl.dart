



import 'package:arnuvapp/modulos/generales/domain/domain.dart';

import '../infraestructure.dart';


class CatalogoDetalleRepositoryImpl extends CatalogoDetalleRepository {

  final CatalogoDetalleDataSource dataSource;

  CatalogoDetalleRepositoryImpl({
    CatalogoDetalleDataSource? dataSource
  }) : dataSource = dataSource ?? CatalogoDetalleDataSourceImpl();
  
  @override
  Future<CatalogoDetalle> crear(CatalogoDetalle catalogodetalle) {
    return dataSource.crear(catalogodetalle);
  }
  
  @override
  Future<CatalogoDetalle> editar(CatalogoDetalle catalogodetalle) {
    return dataSource.editar(catalogodetalle);
  }
  
  @override
  Future<bool> eliminar(CatalogoDetalle catalogodetalle) {
    return dataSource.eliminar(catalogodetalle);
  }
  
  @override
  Future<List<CatalogoDetalle>> listar(int limit, int page) {
    return dataSource.listar(limit, page);
  }
  
  @override
  Future<List<CatalogoDetalle>> listarByIdCatalogo(int limit, int page, int idcatalogo) {
    return dataSource.listarByIdCatalogo(limit, page, idcatalogo);
  }
  
  

}