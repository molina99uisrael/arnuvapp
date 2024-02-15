
import 'package:arnuvapp/modulos/autenticacion/domain/domain.dart';
import 'package:arnuvapp/modulos/autenticacion/presentacion/providers/providers.dart';
import 'package:arnuvapp/modulos/generales/domain/domain.dart';
import 'package:arnuvapp/modulos/generales/presentacion/providers/providers.dart';
import 'package:arnuvapp/modulos/personas/domain/domain.dart';
import 'package:arnuvapp/modulos/personas/infraestructura/infraestructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/modulos/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final usuarioUnificadoFormProvider = StateNotifierProvider.autoDispose<UsuarioUnificadoFormNotifier,UsuarioUnificadoFormState>((ref) {

  final repository = UsuarioDetalleRepositoryImpl();
  final metodoRol = ref.watch(rolDropdownProvider.notifier).getRegistroSeleccionado;
  final metodoCatalogoDetalle = ref.watch(catalogoDetalleDropdownProvider.notifier).getRegistroSeleccionado;

  return UsuarioUnificadoFormNotifier(
    usuarioRepository: repository,
    regSelRolCallback: metodoRol,
    regSelCatDetalleCallback: metodoCatalogoDetalle
  );
});


//! 2 - Como implementamos un notifier
class UsuarioUnificadoFormNotifier extends ArnuvNotifier<UsuarioUnificadoFormState> {

  final UsuarioDetalleRepository usuarioRepository;
  final Rol Function() regSelRolCallback;
  final CatalogoDetalle Function() regSelCatDetalleCallback;

  UsuarioUnificadoFormNotifier({
    required this.usuarioRepository,
    required this.regSelRolCallback,
    required this.regSelCatDetalleCallback,
  }): super( UsuarioUnificadoFormState(registro: usuarioUnificadoDefault.clone(), formKey: GlobalKey<FormState>()) );
  
  refrescar(dynamic context, Function() onRefresh) {
    state = state.copyWith(registro: usuarioUnificadoDefault.clone(), esValidoForm: false);
    onRefresh();
  }
  Future<void> guardar(dynamic context, Function() onRefresh) async {
    super.showLoading(context);
    await Future.delayed(const Duration(seconds: 1));
    try {
      var rol = regSelRolCallback();
      if (rol.id == 0) {
        throw PersonaException("Seleccione un rol");
      }
      var catdet = regSelCatDetalleCallback();
      if (catdet.id.iddetalle.isEmpty) {
        throw PersonaException("Seleccione tipo de identificación");
      }
      state = state.copyWith(
        registro: state.registro.copyWith(
          password: ArnuvUtils.hashSHA256(state.registro.password),
          idcatalogoidentificacion: catdet.id.idcatalogo,
          iddetalleidentificacion: catdet.id.iddetalle,
          idrol: rol.id
        ));
      var exitoso = await usuarioRepository.guardarUsuarioUnificado(state.registro);
      if (exitoso) {
        state = state.copyWith(registro: usuarioUnificadoDefault.clone());
        super.setMensajeExito("REGISTRO GUARDADO");
        onRefresh();
      } else {
        super.setMensajeError("ERROR AL INGRESAR EL REGISTRO");
      }
    } on PersonaException catch (e) {
      super.setMensajeError(e.message);
    }
    super.closeLoading(context);
  }

  esFormularioValido() {
    state = state.copyWith( esValidoForm: false );
    if (state.formKey.currentState?.validate() != true) return;
    state = state.copyWith( esValidoForm: true );
  }

}


//! 1 - State del provider
class UsuarioUnificadoFormState extends ArnuvState {

  final UsuarioUnificado registro;
  final bool esValidoForm;
  GlobalKey<FormState> formKey;

  UsuarioUnificadoFormState({
    required this.registro,
    this.esValidoForm = false,
    required this.formKey,
    super.errorMessage,
    super.succesMessage,
  });

  UsuarioUnificadoFormState copyWith({
    UsuarioUnificado? registro,
    bool? esValidoForm,
    GlobalKey<FormState>? formKey
  }) => UsuarioUnificadoFormState(
    registro: registro ?? this.registro,
    esValidoForm: esValidoForm ?? this.esValidoForm,
    formKey: formKey ?? this.formKey,
  );
  
  @override
  ArnuvState copyWithArnuv({String? errorMessage, String? succesMessage}) => UsuarioUnificadoFormState(
    formKey: formKey,
    registro: registro,
    esValidoForm: esValidoForm,
    errorMessage: errorMessage ?? super.errorMessage,
    succesMessage: succesMessage ?? super.succesMessage
  );

}
