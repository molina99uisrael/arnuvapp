
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

abstract class ArnuvNotifier<T> extends StateNotifier<T> {

  ArnuvNotifier(super.state);

  void setMensajeError( [String? errorMessage, BuildContext? context] ) {
    
    if (super.state != null && errorMessage != null) {
      super.state = (super.state as dynamic).copyWithArnuv(errorMessage: errorMessage);
    }
    if (context != null) {
      closeLoading(context);
    }
  }

  void setMensajeExito( [String? succesMessage, BuildContext? context] ) {
    
    if (super.state != null && succesMessage != null) {
      super.state = (super.state as dynamic).copyWithArnuv(succesMessage: succesMessage);
    }
    if (context != null) {
      closeLoading(context);
    }
  }

  void showLoading(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const Border.symmetric(horizontal: BorderSide.none,vertical: BorderSide.none),
      builder: (BuildContext context) {
        return const SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: SpinKitDoubleBounce(
              color: Colors.blueAccent,
              size: 100.0,
            ),
          ),
        );
      },
    );
  }
  
  void closeLoading(BuildContext context) {
    Navigator.pop(context);
  }

}


abstract class ArnuvState {

  final String errorMessage;
  final String succesMessage;

  ArnuvState({
    this.errorMessage = '',
    this.succesMessage = ''
  });


  ArnuvState copyWithArnuv({
    String? errorMessage,
    String? succesMessage
  }) ;


}

abstract class ArnuvCrud<T> {

  limpiarRegistro();

  listar(int limit, int page);

  guardar();

  actualizar( T reg);

  eliminar( T reg);

  seleccionaRegistro( T reg);

}