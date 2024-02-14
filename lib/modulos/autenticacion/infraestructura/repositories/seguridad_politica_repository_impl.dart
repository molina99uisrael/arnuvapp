

import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';

import '../infrastructure.dart';


class SeguridadPoliticaRepositoryImpl extends SeguridadPoliticaRepository {

  final SeguridadPoliticaDataSource dataSource;

  SeguridadPoliticaRepositoryImpl({
    SeguridadPoliticaDataSource? dataSource
  }) : dataSource = dataSource ?? SeguridadPoliticaDataSourceImpl();
  
  @override
  Future<SeguridadPolitica> crear(SeguridadPolitica segpolitica) {
    return dataSource.crear(segpolitica);
  }
  
  @override
  Future<SeguridadPolitica> editar(SeguridadPolitica segpolitica) {
    return dataSource.editar(segpolitica);
  }
  
  @override
  Future<bool> eliminar(SeguridadPolitica segpolitica) {
    return dataSource.eliminar(segpolitica);
  }
  
  @override
  Future<List<SeguridadPolitica>> listar(int limit, int page) {
    return dataSource.listar(limit, page);
  }

}