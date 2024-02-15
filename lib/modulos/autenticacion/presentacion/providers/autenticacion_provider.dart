import 'package:arnuvapp/modulos/shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/autenticacion/infraestructura/infrastructure.dart';


final authProvider = StateNotifierProvider<AuthNotifier,AuthState>((ref) {

  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();


  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService
  );
});



class AuthNotifier extends ArnuvNotifier<AuthState>  {

  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }): super( AuthState() ) {
    checkLogin();
  }

  void checkLogin() async {
    final token = await keyValueStorageService.getValue<String>('Authorization');
    if( token == null ) return logout();

    try {
      final menu = await authRepository.checkMenuLogin();
      state = state.copyWith(
        user: menu.dto,
        menu: menu.lista,
        authStatus: AuthStatus.authenticated,
      );

    } on AutenticacionException catch (e) {
      logout( e.message );
      state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
      );
    } on SystemException catch (e){
      logout( e.message );
      state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
      );
    } catch (e) {
      state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
      );
      logout(e.toString());
    }

  }

  Future<void> loginUser( String email, String password, dynamic context ) async {
    super.showLoading(context);
    await keyValueStorageService.removeKey('Authorization');
    await Future.delayed(const Duration(seconds: 1));

    try {
      final user = await authRepository.login(email, password);
      final menu = await authRepository.checkMenuLogin();
      _setUsuarioLogeado( user, menu.lista );
    } on AutenticacionException catch (e) {
      logout( e.message );
    } on SystemException catch (e){
      logout( e.message );
    } catch (e){
      logout( 'Error no controlado: ${e.toString()}' );
    }
    super.closeLoading(context);

  }

  void registerUser( String email, String password ) async {
    
  }

  void _setUsuarioLogeado( User user, List<Menu>? menu ) async {
    try {
      state = state.copyWith(
        user: user,
        menu: menu,
        authStatus: AuthStatus.authenticated,
      );
    } catch (e) {
      setMensajeError(e.toString());
    }
  }

  Future<void> logout([ String? errorMessage ]) async {
    
    await keyValueStorageService.removeKey('Authorization');

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
    );
    setMensajeError(errorMessage);
  }

  void setOpcionMenu(Item item) {
    state = state.copyWith(opcionesMenu: item);
  }

}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState extends ArnuvState {

  final AuthStatus authStatus;
  final User? user;
  final List<Menu>? menu;
  final Item? opcionesMenu;

  AuthState({
    this.authStatus = AuthStatus.checking, 
    this.user,
    this.menu,
    this.opcionesMenu,
    super.errorMessage,
    super.succesMessage
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    List<Menu>? menu,
    Item? opcionesMenu
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    menu: menu ?? this.menu,
    opcionesMenu: opcionesMenu ?? this.opcionesMenu
  );

  AuthState limpiarState() => AuthState(
    user: null,
    menu: [],
    authStatus: AuthStatus.checking,
    opcionesMenu: null,
    errorMessage: "",
    succesMessage: "",
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => AuthState(
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage,
    authStatus: authStatus,
    user: user,
    menu: menu,
    opcionesMenu: opcionesMenu
  );

}