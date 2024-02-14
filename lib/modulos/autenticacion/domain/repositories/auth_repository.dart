
import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';

abstract class AuthRepository {

  Future<User> login( String email, String password );
  
  Future<MenuResponse> checkMenuLogin();

}

