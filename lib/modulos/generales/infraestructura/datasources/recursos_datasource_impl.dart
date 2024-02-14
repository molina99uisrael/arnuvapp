import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/infraestructura/infraestructure.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

class RecursosDataSourceImpl extends RecursosDataSource with ArnuvServicios {
  @override
  Future<Recursos> crear(Recursos recursos) async {
    try {
      final data = RecursosMapper.entityToJsonData(recursos);
      final response = await postServicio('/recursos/crear', data: data);
      var resp = Recursos.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw GeneralesException(e.message);
    }
  }

  @override
  Future<Recursos> editar(Recursos recursos) async {
    try {
      final data = RecursosMapper.entityToJsonData(recursos);
      final response = await putServicio('/recursos/actualizar', data: data );
      var resp = Recursos.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw GeneralesException(e.message);
    }
  }

  @override
  Future<bool> eliminar(Recursos recursos) {
    // TODO: implement eliminar
    throw UnimplementedError();
  }

  @override
  Future<List<Recursos>> listar(int limit, int page) async {
    try {
      final response = await getServicio('/recursos/listar');
      var resp = RecursosMapper.listaJsonToList(response.data["lista"]);
      return resp;
    } on SystemException catch (e) {
      throw GeneralesException(e.message);
    }
  }
  
  @override
  Future<List<Recursos>> listarByIdModulo(int limit, int page, int idmodulo) async {
    try {
      final response = await getServicio('/recursos/buscarporidmodulo/$idmodulo');
      var resp = RecursosMapper.listaJsonToList(response.data["lista"]);
      return resp;
    } on SystemException catch (e) {
      throw GeneralesException(e.message);
    }
  }
  
}
