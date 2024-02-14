
import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import '../errors/auth_errors.dart';


class UserMapper {

  static User userJsonToEntity( Map<String,dynamic> json ) {
    try {
      return User( username: json['username'], nrol: json['nrol'], email: json['email'] );
    } catch (e) {
      throw AutenticacionException( e.toString());
    }
  } 

}

