


import 'package:arnuvapp/modulos/personas/domain/domain.dart';
import '../infraestructure.dart';


class PersonaDetalleRepositoryImpl extends PersonaDetalleRepository {

  final PersonaDetalleDataSource dataSource;

  PersonaDetalleRepositoryImpl({
    PersonaDetalleDataSource? dataSource
  }) : dataSource = dataSource ?? PersonaDetalleDataSourceImpl();
  
  @override
  Future<List<PersonaDetalle>> listar(int limit, int page) {
    return dataSource.listar(limit, page);
  }
  
  @override
  Future<PersonaDetalle> crear(PersonaDetalle persona) {
    return dataSource.crear(persona);
  }
  
  @override
  Future<PersonaDetalle> editar(PersonaDetalle persona) {
    return dataSource.editar(persona);
  }
  
  @override
  Future<bool> eliminar(PersonaDetalle persona) {
    return dataSource.eliminar(persona);
  }
  
  @override
  Future<PersonaDetalle> buscarPorIdentificacion(String identificacion) {
    return dataSource.buscarPorIdentificacion(identificacion);
  }

}