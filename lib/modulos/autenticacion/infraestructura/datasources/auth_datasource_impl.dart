import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/autenticacion/infraestructura/errors/auth_errors.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

class AuthDataSourceImpl extends AuthDataSource with ArnuvServicios {

  final keyValueStorageService = KeyValueStorageServiceImpl();

  @override
  Future<User> login(String email, String password) async {
    final response = await postServicio('/api/autenticacion/login', data: {
      'serial': await getUuid(true),
      'email': email,
      'password': password
    });
    try {
      String token = response.headers.value('Authorization')!;
      await keyValueStorageService.setKeyValue<String>('Authorization', token);
    } catch ( e ) {
      throw SystemException(e.toString());
    }
    return User.fromJson(response.data["dto"]);
  }
  
  @override
  Future<MenuResponse> checkMenuLogin() async {
    final response = await postServicio('/api/autenticacion/menu');

    var resp = MenuResponse.fromJson(response.data);
    if (resp.lista == []) {
      throw AutenticacionException("NO EXISTE INFORMACION DEL USUARIO");
    }
    int index = 1;
    for (var menu in resp.lista) {
      for (var itemmenu in menu.items) {
        itemmenu.index = index;
        index++;
      }
    }
    return resp;
  }
  
}
