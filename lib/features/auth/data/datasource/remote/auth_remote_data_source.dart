import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/api/api_client.dart';
import 'package:hamro_bhagaicha_batch35d/core/api/api_endpoint.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/storage/token_service.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/storage/user_session_service.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/datasource/auth_datasource.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_api_model.dart';


final authRemoteDatasourceProvider = Provider<IAuthRemoteDatasource>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return AuthRemoteDatasource(apiClient: apiClient, 
  userSessionService: ref.read(userSessionServiceProvider),
    tokenService: ref.read(tokenServiceProvider),
  );
});

class AuthRemoteDatasource implements IAuthRemoteDatasource {
  final ApiClient _apiClient;
   final UserSessionService _userSessionService;
   final TokenService _tokenService;

  AuthRemoteDatasource({
  required ApiClient apiClient, 
  required UserSessionService userSessionService, 
  required TokenService tokenService,}) 
  : _apiClient = apiClient,
  _userSessionService = userSessionService,
       _tokenService = tokenService;

  @override
  Future<AuthApiModel> register(AuthApiModel user) async {
    // final response = await _apiClient.post(
    //   '/auth/register',
    //   data: model.toJson(),
    // );

    // if (response.statusCode == 201 || response.statusCode == 200) {
    //   return AuthApiModel.fromJson(response.data);
    // } else {
    //   throw Exception('Failed to register user: ${response.data}');
    // }
    final response = await _apiClient.post(
      ApiEndpoints.authRegister,
      data: user.toJson(),
    );

    if (response.data['success'] == true) {
      final data = response.data['data'] as Map<String, dynamic>;
      final registeredUser = AuthApiModel.fromJson(data);
      return registeredUser;
    }
    return user;
  }
  
  @override
  Future<AuthApiModel?> login(String email, String password) async {
    final response = await _apiClient.post(
      ApiEndpoints.authLogin,
      data: {'email': email, 'password': password},
    );
    if (response.data['success'] == true) {
      debugPrint('Login response: ${response.data}');
      final data = response.data['data'] as Map<String, dynamic>? ?? <String, dynamic>{};
      final user = AuthApiModel.fromJson(data);

      // Defensive user id extraction (backend may return _id or id)
      final userId = user.authId ?? data['_id']?.toString() ?? data['id']?.toString();
      if (userId == null || userId.isEmpty) {
        throw Exception('Login response missing user id');
      }

      await _userSessionService.saveUserSession(
        userId: userId,
        fullname: user.fullname,
        email: user.email,
        address: user.address,
        phoneNumber: user.phoneNumber,
      );

      // Defensive token extraction
      final token = response.data['token'] ?? data['token'];
      if (token != null && token.toString().isNotEmpty) {
        await _tokenService.saveToken(token.toString());
      } else {
        debugPrint('No token found in login response');
      }

      return user;
    }
    return null;
  }


  

  @override
  Future<String> updateProfileImage(File imageFile) async {
    final token = await _tokenService.getToken();
    final fileName = imageFile.path.split('/').last;

    final formData = FormData.fromMap({
      'profileUrl': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      ),
    });

    final response = await _apiClient.put(
      ApiEndpoints.updateProfileImage,
      data: formData,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        contentType: 'multipart/form-data',
      ),
    );

    final dynamic profileUrlRaw = response.data['data']?['profileUrl'] ?? response.data['profileUrl'];

    if (profileUrlRaw == null) {
      debugPrint('Update profile response: ${response.data}');
      throw Exception('Failed to upload profile image: profileUrl missing');
    }

    final profileUrl = profileUrlRaw.toString();
    if (profileUrl.isEmpty) {
      throw Exception('Failed to upload profile image: empty url');
    }

    return profileUrl;
  }
  
  @override
  Future<AuthApiModel?> getCurrentUserById(String userId) async{
    final token = await _tokenService.getToken();
    final response = await _apiClient.get(
      ApiEndpoints.getCurrentUserById(userId),
      options: Options(headers: {'Authorization': 'Bearer $token'},contentType: 'multipart/form-data',),
    );
    if (response.data['success'] == true) {
      final data = response.data['data'] as Map<String, dynamic>;
      return AuthApiModel.fromJson(data);
    }
    return null;
  }
}


