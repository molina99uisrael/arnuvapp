



import 'package:arnuvapp/modulos/generales/domain/domain.dart';

import '../infraestructure.dart';


class ModulosRepositoryImpl extends ModulosRepository {

  final ModulosDataSource dataSource;

  ModulosRepositoryImpl({
    ModulosDataSource? dataSource
  }) : dataSource = dataSource ?? ModulosDataSourceImpl();
  
  @override
  Future<Modulos> crear(Modulos modulo) {
    return dataSource.crear(modulo);
  }
  
  @override
  Future<Modulos> editar(Modulos modulo) {
    return dataSource.editar(modulo);
  }
  
  @override
  Future<bool> eliminar(Modulos modulo) {
    return dataSource.eliminar(modulo);
  }
  
  @override
  Future<List<Modulos>> listar(int limit, int page) {
    return dataSource.listar(limit, page);
  }
  

}