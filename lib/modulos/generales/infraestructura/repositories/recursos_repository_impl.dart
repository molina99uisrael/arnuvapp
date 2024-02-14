



import 'package:arnuvapp/modulos/generales/domain/domain.dart';

import '../infraestructure.dart';


class RecursosRepositoryImpl extends RecursosRepository {

  final RecursosDataSource dataSource;

  RecursosRepositoryImpl({
    RecursosDataSource? dataSource
  }) : dataSource = dataSource ?? RecursosDataSourceImpl();
  
  @override
  Future<Recursos> crear(Recursos recursos) {
    return dataSource.crear(recursos);
  }
  
  @override
  Future<Recursos> editar(Recursos recursos) {
    return dataSource.editar(recursos);
  }
  
  @override
  Future<bool> eliminar(Recursos recursos) {
    return dataSource.eliminar(recursos);
  }
  
  @override
  Future<List<Recursos>> listar(int limit, int page) {
    return dataSource.listar(limit, page);
  }
  
  @override
  Future<List<Recursos>> listarByIdModulo(int limit, int page, int idmodulo) {
    return dataSource.listarByIdModulo(limit, page, idmodulo);
  }
  
  

}