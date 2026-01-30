import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/storage/token_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:hamro_bhagaicha_batch35d/core/api/api_endpoint.dart';


// Provider
final apiClientProvider = Provider<ApiClient>((ref) {
  final tokenService = ref.read(tokenServiceProvider);
  return ApiClient(tokenService: tokenService);
});

class ApiClient {
  final Dio _dio = Dio();
  final TokenService _tokenService;

  ApiClient({required TokenService tokenService}) : _tokenService = tokenService {
    _dio.options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: ApiEndpoints.connectionTimeout,
      receiveTimeout: ApiEndpoints.receiveTimeout,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio.interceptors.add(_AuthInterceptor(_tokenService));

    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ));
    }
  }

  Dio get dio => _dio;

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    return _dio.get(path, queryParameters: queryParameters, options: options);
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    return _dio.post(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    return _dio.put(path, data: data, queryParameters: queryParameters, options: options);
  }
}

class _AuthInterceptor extends Interceptor {
  final TokenService _tokenService;
  static const List<String> _publicEndpoints = [
    ApiEndpoints.authLogin,
    ApiEndpoints.authRegister,
  ];

  _AuthInterceptor(this._tokenService);

  bool _isPublicEndpoint(String path) {
    return _publicEndpoints.any((e) => path.startsWith(e));
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!_isPublicEndpoint(options.path)) {
      final token = await _tokenService.getToken();
if (token != null && token.isNotEmpty) {
  options.headers['Authorization'] = 'Bearer $token';
}
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _tokenService.removeToken();
    }
    handler.next(err);
  }
}
