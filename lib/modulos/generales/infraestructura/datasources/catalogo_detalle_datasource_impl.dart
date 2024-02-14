import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/infraestructura/infraestructure.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

class CatalogoDetalleDataSourceImpl extends CatalogoDetalleDataSource with ArnuvServicios {
  @override
  Future<CatalogoDetalle> crear(CatalogoDetalle catalogodetalle) async {
    try {
      final data = CatalogoDetalleMapper.entityToJsonData(catalogodetalle);
      final response = await postServicio('/catalogo-detalle/crear', data: data);
      var resp = CatalogoDetalle.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw GeneralesException(e.message);
    }
  }

  @override
  Future<CatalogoDetalle> editar(CatalogoDetalle catalogodetalle) async {
    try {
      final data = CatalogoDetalleMapper.entityToJsonData(catalogodetalle);
      final response = await putServicio('/catalogo-detalle/actualizar', data: data );
      var resp = CatalogoDetalle.fromJson(response.data["dto"]);
      return resp;
    } on SystemException catch (e) {
      throw GeneralesException(e.message);
    }
  }

  @override
  Future<bool> eliminar(CatalogoDetalle catalogodetalle) {
    // TODO: implement eliminar
    throw UnimplementedError();
  }

  @override
  Future<List<CatalogoDetalle>> listar(int limit, int page) async {
    try {
      final response = await getServicio('/catalogo-detalle/listar');
      var resp = CatalogoDetalleMapper.listaJsonToList(response.data["lista"]);
      return resp;
    } on SystemException catch (e) {
      throw GeneralesException(e.message);
    }
  }

  @override
  Future<List<CatalogoDetalle>> listarByIdCatalogo(int limit, int page, int idcatalogo) async {
    try {
      final response = await getServicio('/catalogo-detalle/listarCatalogo/$idcatalogo');
      var resp = CatalogoDetalleMapper.listaJsonToList(response.data["lista"]);
      return resp;
    } on SystemException catch (e) {
      throw GeneralesException(e.message);
    }
  }
  
  
  
 
  
}
