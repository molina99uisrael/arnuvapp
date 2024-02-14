import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';

abstract class AuthDataSource {

  Future<User> login( String email, String password );

  Future<MenuResponse> checkMenuLogin();

}

