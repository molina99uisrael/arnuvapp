import 'package:arnuvapp/modulos/shared/infrastructure/errors/system_errors.dart';
import 'package:dio/dio.dart';
import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'package:arnuvapp/config/config.dart';
import 'package:arnuvapp/modulos/shared/infrastructure/services/key_value_storage_service_impl.dart';
import 'package:arnuvapp/modulos/shared/utils/device_helper.dart';
import 'package:arnuvapp/modulos/shared/utils/arnuv_interceptors.dart';
import 'package:uuid/uuid.dart';

mixin ArnuvServicios {

  final _keyValueStorageService = KeyValueStorageServiceImpl();

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    )
  );

  Future<Response<T>> postServicio<T>(String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    
    try {
      dio.interceptors.add(ArnuvInterceptors());

      return await dio.post(path, data: data, queryParameters: queryParameters, options: options, 
        cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress:onReceiveProgress );
    } on DioException catch (e) {
      if( e.response?.statusCode == 400 ){
        throw SystemException('${e.response?.data['message']}');
      }
      if( e.response?.statusCode == 401 || e.response?.statusCode == 403 ){
        throw SystemException('Token incorrecto');
      }
      if( e.response?.statusCode == 500 ){
        throw SystemException('${e.response?.data['message']}');
      }
      if( e.response?.statusCode == 404 ){
        throw SystemException('${e.response?.data['message']}');
      }
      throw SystemException('Error en el consumo del servicio: ${e.message}');
    } catch (e) {
      throw Exception();
    }
  }

  Future<Response<T>> getServicio<T>(String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    
    try {
      dio.interceptors.add(ArnuvInterceptors());

      return await dio.get(path, data: data, queryParameters: queryParameters, options: options, 
        cancelToken: cancelToken, onReceiveProgress:onReceiveProgress );
    } on DioException catch (e) {
      if( e.response?.statusCode == 400 ){
        throw SystemException('${e.response?.data['message']}');
      }
      if( e.response?.statusCode == 401 || e.response?.statusCode == 403 ){
        throw SystemException('Token incorrecto');
      }
      if( e.response?.statusCode == 500 ){
        throw SystemException('${e.response?.data['message']}');
      }
      if( e.response?.statusCode == 404 ){
        throw SystemException('${e.response?.data['message']}');
      }
      throw SystemException('Error en el consumo del servicio: ${e.message}');
    } catch (e) {
      throw Exception();
    }
  }

  Future<Response<T>> putServicio<T>(String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    
    try {
      dio.interceptors.add(ArnuvInterceptors());

      return await dio.put(path, data: data, queryParameters: queryParameters, options: options, 
        cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress:onReceiveProgress );
    } on DioException catch (e) {
      if( e.response?.statusCode == 400 ){
        throw SystemException('${e.response?.data['message']}');
      }
      if( e.response?.statusCode == 401 || e.response?.statusCode == 403 ){
        throw SystemException('Token incorrecto');
      }
      if( e.response?.statusCode == 500 ){
        throw SystemException('${e.response?.data['message']}');
      }
      if( e.response?.statusCode == 404 ){
        throw SystemException('${e.response?.data['message']}');
      }
      throw SystemException('Error en el consumo del servicio: ${e.message}');
    } catch (e) {
      throw Exception();
    }
  }

  Future<dynamic> obtenerDatosDispositivo(String key) async {
    try {
      var plataforma = await DevicesHelper.initPlatformState();
      return plataforma[key];
    } catch (e) {
      throw SystemException('Error en el consumo del servicio: ${e.toString()}');
    }
  }

  Future<String> getUuid([ bool generar = false]) async {

    var serial = await _keyValueStorageService.getValue<String>('serial');
    if (serial != null) {
      return serial;
    }

    const uuid = Uuid();
    final uuidString = uuid.v4(config: V4Options(null, CryptoRNG())).replaceAll("-", "").substring(0, 30);

    await _keyValueStorageService.setKeyValue<String>('serial', uuidString);

    return uuidString;
  }

}