import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/connectivity/network_info.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/datasource/auth_datasource.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/datasource/local/auth_local_datasource.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/datasource/remote/auth_remote_data_source.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_api_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_hive_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/repositories/auth_repository.dart';

/// Provider
final authRepositoryProvider = Provider<IAuthRepository>((ref) {
final authLocalDatasource = ref.read(authLocalDatasourceProvider);

  final authRemoteDatasource = ref.read(authRemoteDatasourceProvider);
  final networkInfo = ref.read(networkInfoProvider);

  return AuthRepository(
    authDatasource: authLocalDatasource,
    authRemoteDatasource: authRemoteDatasource,
    networkInfo: networkInfo,
  );
});

class AuthRepository implements IAuthRepository {
  final IAuthLocalDatasource _authDatasource;
  final IAuthRemoteDatasource _authRemoteDatasource;
  final NetworkInfo _networkInfo;

  AuthRepository({
    required IAuthLocalDatasource authDatasource,
    required IAuthRemoteDatasource authRemoteDatasource,
    required NetworkInfo networkInfo,
  })  : _authDatasource = authDatasource,
        _authRemoteDatasource = authRemoteDatasource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final user = await _authDatasource.getCurrentUser();
      if (user != null) {
        return Right(user.toEntity());
      }
      return Left(LocalDatabaseFailure(message: 'No user logged in'));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> login(String email, String password) async {
    if (await _networkInfo.isConnected) {
      // Use remote API
      try {
        final apiModel = await _authRemoteDatasource.login(email, password);
        if (apiModel != null) {
          return Right(apiModel.toEntity());
        }
        return const Left(ApiFailure(message: 'Invalid email or password'));
      } on DioException catch (e) {
        return Left(ApiFailure(
          message: e.response?.data['message'] ?? 'Login failed',
          statusCode: e.response?.statusCode,
        ));
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    } else {
      // Use local Hive datasource
      try {
        final user = await _authDatasource.login(email, password);
        if (user != null) {
          return Right(user.toEntity());
        }
        return const Left(LocalDatabaseFailure(message: 'Invalid email or password'));
      } catch (e) {
        return Left(LocalDatabaseFailure(message: e.toString()));
      }
    }
  }


  @override
  Future<Either<Failure, bool>> register(AuthEntity user) async {
    if (await _networkInfo.isConnected) {
      // Remote registration
      try {
        final apiModel = AuthApiModel.fromEntity(user);
        await _authRemoteDatasource.register(apiModel);

        await _authDatasource.register(AuthHiveModel.fromEntity(user));


        return const Right(true);
      } on DioException catch (e) {
        return Left(ApiFailure(
          message: e.response?.data['message'] ?? 'Registration failed',
          statusCode: e.response?.statusCode,
        ));
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    } else {
      // Offline registration in Hive
      try {
        if (await _authDatasource.isEmailExists(user.email)) {
          return const Left(LocalDatabaseFailure(message: 'Email already exists'));
        }

        final authModel = AuthHiveModel(
          fullName: user.fullname,
          email: user.email,
          password: user.password,
          address: user.address,
          phoneNumber: user.phoneNumber,
        );

        await _authDatasource.register(authModel);
        return const Right(true);
      } catch (e) {
        return Left(LocalDatabaseFailure(message: e.toString()));
      }
    }
  }
  
  @override
  Future<Either<Failure, bool>> logout() async {
      try {
    await _authDatasource.logout();
    return const Right(true);
   }catch (e) {
    return Left(LocalDatabaseFailure(message: e.toString()));
   }
  }
  
@override
Future<Either<Failure, AuthEntity>> updateProfileImage(File imageFile) async {
  if (await _networkInfo.isConnected) {
    try {
      final apiModel =
          await _authRemoteDatasource.updateProfileImage(imageFile);

      // OPTIONAL: cache updated user locally
      await _authDatasource.saveCurrentUser(
        AuthHiveModel.fromApiModel(apiModel),
      );

      return Right(apiModel.toEntity());
    } on DioException catch (e) {
      return Left(
        ApiFailure(
          message: e.response?.data['message'] ?? 'Update profile image failed',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  } else {
    return const Left(
      ApiFailure(message: 'No internet connection'),
    );
  }
}


  

}


