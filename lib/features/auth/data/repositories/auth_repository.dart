// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/data/datasource/auth_datasource.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/data/datasource/local/auth_local_datasource.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_hive_model.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/domain/repositories/auth_repository.dart';

// //provider
// final authRepositoryProvider = Provider<IAuthRepository>((ref){
//   return AuthRepository(authDataSource: ref.read(authLocalDatasourceProvider));
// });

// class AuthRepository implements IAuthRepository{
//   final IAuthLocalDatasource _authDatasource;

//   AuthRepository({required IAuthLocalDatasource authDataSource})
//   : _authDatasource = authDataSource;

//   @override
//   Future<Either<Failure, AuthEntity>> getCurrentUser() {
//     // TODO: implement getCurrentUser
//     throw UnimplementedError();
//   }

//   @override
//   Future<Either<Failure, AuthEntity>> login(String email, String password) async {
//      try{
//       final user = await _authDatasource.login(email, password);
//       if (user != null) {
//         final entity = user.toEntity();
//         return Right(entity);
//       }
//       return Left(LocalDatabaseFailure(message: "Invalid email or password"));
//      } catch (e) {
//       return Left(LocalDatabaseFailure(message: e.toString()));
//      }
//   }

//   @override
//   Future<Either<Failure, bool>> register(AuthEntity entity) async {
//    try {
//       final model = AuthHiveModel.fromEntity(entity);
//       final result = await _authDatasource.register(model);
//       if (result) {
//         return Right(true);
//       }
//       return Left(LocalDatabaseFailure(message: "Failed to register user"));
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: e.toString()));
//     }
//   }
  
//   @override
//   Future<Either<Failure, AuthEntity>> getUserByPhoneNumber(String phoneNumber) {
//     // TODO: implement getUserByPhoneNumber
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, bool>> isPhoneNumberExists(String phoneNumber) {
//     // TODO: implement isPhoneNumberExists
//     throw UnimplementedError();
//   }
  

// }


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

// Provider for AuthRepository
final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final localDatasource = ref.read(authLocalDatasourceProvider);
  final remoteDatasource = ref.read(authRemoteDatasourceProvider);
  final networkInfo = ref.read(networkInfoProvider);

  return AuthRepository(
    authLocalDatasource: localDatasource,
    authRemoteDatasource: remoteDatasource,
    networkInfo: networkInfo,
  );
});

class AuthRepository implements IAuthRepository {
  final IAuthLocalDatasource _authLocalDatasource;
  final IAuthRemoteDatasource _authRemoteDatasource;
  final NetworkInfo _networkInfo;

  AuthRepository({
    required IAuthLocalDatasource authLocalDatasource,
    required IAuthRemoteDatasource authRemoteDatasource,
    required NetworkInfo networkInfo,
  })  : _authLocalDatasource = authLocalDatasource,
        _authRemoteDatasource = authRemoteDatasource,
        _networkInfo = networkInfo;

  // Get user by phone number
  @override
  Future<Either<Failure, AuthEntity>> getUserByPhoneNumber(
      String phoneNumber) async {
    try {
      final localUser =
          await _authLocalDatasource.getUserByPhoneNumber(phoneNumber);

      if (localUser != null) {
        return Right(localUser.toEntity());
      }

      return const Left(LocalDatabaseFailure(message: "User not found"));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  // Check if phone number exists
  @override
  Future<Either<Failure, bool>> isPhoneNumberExists(String phoneNumber) async {
    try {
      final exists = await _authLocalDatasource.isPhoneNumberExists(phoneNumber);
      return Right(exists);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  // Login
  @override
  Future<Either<Failure, AuthEntity>> login(
      String phoneNumber, String password) async {
    if (await _networkInfo.isConnected) {
      // Use remote API
      try {
        final apiModel =
            await _authRemoteDatasource.login(phoneNumber, password);

        if (apiModel != null) {
          // Save locally after successful remote login
          final localModel = AuthHiveModel.fromEntity(apiModel.toEntity());
          await _authLocalDatasource.register(localModel);

          return Right(apiModel.toEntity());
        }

        return const Left(ApiFailure(message: "Invalid credentials"));
      } on DioException catch (e) {
        return Left(
          ApiFailure(
            message: e.response?.data['message'] ?? "Login failed",
            statusCode: e.response?.statusCode,
          ),
        );
      } catch (e) {
        return Left(LocalDatabaseFailure(message: e.toString()));
      }
    } else {
      // Use local Hive datasource
      try {
        final localUser = await _authLocalDatasource.login(phoneNumber, password);
        if (localUser != null) {
          return Right(localUser.toEntity());
        }
        return const Left(
          LocalDatabaseFailure(message: "Invalid phone number or password"),
        );
      } catch (e) {
        return Left(LocalDatabaseFailure(message: e.toString()));
      }
    }
  }

  // Register
  @override
  Future<Either<Failure, bool>> register(AuthEntity entity) async {
    if (await _networkInfo.isConnected) {
      // Remote API registration
      try {
        final apiModel = AuthApiModel.fromEntity(entity);
        await _authRemoteDatasource.register(apiModel);

        // Save locally as well
        final localModel = AuthHiveModel.fromEntity(entity);
        await _authLocalDatasource.register(localModel);

        return const Right(true);
      } on DioException catch (e) {
        return Left(
          ApiFailure(
            message: e.response?.data['message'] ?? "Registration failed",
            statusCode: e.response?.statusCode,
          ),
        );
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    } else {
      // Offline registration in Hive
      try {
        final exists =
            await _authLocalDatasource.isPhoneNumberExists(entity.phoneNumber);
        if (exists) {
          return const Left(
            LocalDatabaseFailure(message: "Phone number already registered"),
          );
        }

        final localModel = AuthHiveModel.fromEntity(entity);
        await _authLocalDatasource.register(localModel);

        return const Right(true);
      } catch (e) {
        return Left(LocalDatabaseFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
}
