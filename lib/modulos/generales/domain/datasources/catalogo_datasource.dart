
import 'package:arnuvapp/modulos/generales/domain/domain.dart';

abstract class CatalogoDataSource {

  Future<List<Catalogo>> listar( int limit, int page );

  Future<Catalogo> crear( Catalogo catalogo );

  Future<Catalogo> editar( Catalogo catalogo );

  Future<bool> eliminar( Catalogo catalogo );

}

