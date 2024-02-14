import 'package:arnuvapp/modulos/personas/domain/domain.dart';
import 'package:arnuvapp/modulos/personas/infraestructura/infraestructure.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

class PersonaDetalleDataSourceImpl extends PersonaDetalleDataSource with ArnuvServicios {
  
  @override
  Future<List<PersonaDetalle>> listar(int limit, int page) async {
    try {
      final response = await getServicio('/personas/listar');
      var resp = PersonaDetalleMapper.listPersonaJsonToList(response.data["lista"]);
      return resp;
    } on SystemException catch (e) {
      throw PersonaException(e.message);
    }
  }
  
  @override
  Future<PersonaDetalle> editar(PersonaDetalle persona) async {
    try {
      final data = PersonaDetalleMapper.entityToJsonData(persona);
      final response = await putServicio('/personas/actualizar', data: data );
      var resp = PersonaDetalle.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw PersonaException(e.message);
    }
  }
  
  @override
  Future<bool> eliminar(PersonaDetalle persona) {
    // TODO: implement eliminar
    throw UnimplementedError();
  }
  
  @override
  Future<PersonaDetalle> crear(PersonaDetalle persona) async {
    try {
      final data = PersonaDetalleMapper.entityToJsonData(persona);
      final response = await postServicio('/personas/crear', data: data);
      var resp = PersonaDetalle.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw PersonaException(e.message);
    }
  }
  
  @override
  Future<PersonaDetalle> buscarPorIdentificacion(String identificacion) async {
    try {
      final response = await getServicio('/personas/buscaridentificacion/$identificacion' );
      var resp = PersonaDetalle.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw PersonaException(e.message);
    }
  }
  
}
