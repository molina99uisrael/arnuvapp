
import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';

abstract class AuthRepository {

  Future<User> login( String email, String password );

  Future<bool> olvidoPassword( String email );

  Future<User> confirmarPassword( String passwordAnterior, String nuevoPass, String confirmacionPass );
  
  Future<MenuResponse> checkMenuLogin();

}

