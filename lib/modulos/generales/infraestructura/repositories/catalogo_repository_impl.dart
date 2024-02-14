



import 'package:arnuvapp/modulos/generales/domain/domain.dart';

import '../infraestructure.dart';


class CatalogoRepositoryImpl extends CatalogoRepository {

  final CatalogoDataSource dataSource;

  CatalogoRepositoryImpl({
    CatalogoDataSource? dataSource
  }) : dataSource = dataSource ?? CatalogoDataSourceImpl();
  
  @override
  Future<Catalogo> crear(Catalogo catalogo) {
    return dataSource.crear(catalogo);
  }
  
  @override
  Future<Catalogo> editar(Catalogo catalogo) {
    return dataSource.editar(catalogo);
  }
  
  @override
  Future<bool> eliminar(Catalogo catalogo) {
    return dataSource.eliminar(catalogo);
  }
  
  @override
  Future<List<Catalogo>> listar(int limit, int page) {
    return dataSource.listar(limit, page);
  }

}