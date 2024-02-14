import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/infraestructura/infraestructure.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

class ModulosDataSourceImpl extends ModulosDataSource with ArnuvServicios {
  @override
  Future<Modulos> crear(Modulos modulo) async {
    try {
      final data = ModulosMapper.entityToJsonData(modulo);
      final response = await postServicio('/modulos/crear', data: data);
      var resp = Modulos.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw GeneralesException(e.message);
    }
  }

  @override
  Future<Modulos> editar(Modulos modulo) async {
    try {
      final data = ModulosMapper.entityToJsonData(modulo);
      final response = await putServicio('/modulos/actualizar', data: data );
      var resp = Modulos.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw GeneralesException(e.message);
    }
  }

  @override
  Future<bool> eliminar(Modulos modulo) {
    // TODO: implement eliminar
    throw UnimplementedError();
  }

  @override
  Future<List<Modulos>> listar(int limit, int page) async {
    try {
      final response = await getServicio('/modulos/listar');
      var resp = ModulosMapper.listaJsonToList(response.data["lista"]);
      return resp;
    } on SystemException catch (e) {
      throw GeneralesException(e.message);
    }
  }
  
}
