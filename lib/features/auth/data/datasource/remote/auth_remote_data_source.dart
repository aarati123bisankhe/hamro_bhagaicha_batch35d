import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/api/api_client.dart';
import 'package:hamro_bhagaicha_batch35d/core/api/api_endpoint.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/datasource/auth_datasource.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_api_model.dart';

// Provider for AuthRemoteDatasource
final authRemoteDatasourceProvider =
    Provider<IAuthRemoteDatasource>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return AuthRemoteDatasource(apiClient: apiClient);
});

class AuthRemoteDatasource implements IAuthRemoteDatasource {
  final ApiClient _apiClient;

  AuthRemoteDatasource({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<AuthApiModel?> login(String phoneNumber, String password) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.authLogin,
        data: {
          'phoneNumber': phoneNumber,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final authModel = AuthApiModel.fromJson(data);

        // Save token if returned
        if (data['token'] != null) {
          await _apiClient.saveToken(data['token']);
        }

        return authModel;
      }

      return null;
    } catch (e) {
      rethrow; // repository will handle DioException
    }
  }

  @override
  Future<AuthApiModel> register(AuthApiModel model) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.authRegister,
        data: model.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data;
        final authModel = AuthApiModel.fromJson(data);

        // Save token if returned
        if (data['token'] != null) {
          await _apiClient.saveToken(data['token']);
        }

        return authModel;
      }

      throw Exception('Registration failed');
    } catch (e) {
      rethrow; // repository will handle DioException
    }
  }
}
