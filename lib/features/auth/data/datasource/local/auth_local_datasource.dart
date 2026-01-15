// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hamro_bhagaicha_batch35d/core/services/hive/hive_service.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/data/datasource/auth_datasource.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_hive_model.dart';

// final authLocalDatasourceProvider =
//     Provider<AuthLocalDatasource>((ref) {
//   final hiveService = ref.watch(hiveServiceProvider);
//   return AuthLocalDatasource(hiveService: hiveService);
// });

// class AuthLocalDatasource implements IAuthLocalDatasource {
//   final HiveService _hiveService;

//   AuthLocalDatasource({required HiveService hiveService})
//       : _hiveService = hiveService;


//   @override
//   Future<AuthHiveModel?> login(String email, String password) async {
//     try {
//       final user = await _hiveService.loginUser(email, password);
//       return Future.value(user);
//     }catch (e) {
//       return Future.value(null);
//     }
//   }

  
//   @override
//   Future<bool> register(AuthHiveModel model) async {
//     try{
//       await _hiveService.registerUser(model);
//       return Future.value(true);
//     }catch (e) {
//       return Future.value(false);
//     }
//   }

//   @override
//   Future<AuthHiveModel?> getCurrentUser() {
//     // TODO: implement getCurrentUser
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<AuthHiveModel?> getUserByPhoneNumber(String phoneNumber) {
//     // TODO: implement getUserByPhoneNumber
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<bool> isPhoneNumberExists(String phoneNumber) {
//     // TODO: implement isPhoneNumberExists
//     throw UnimplementedError();
//   }
// }


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/hive/hive_service.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/storage/user_session_service.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/datasource/auth_datasource.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_hive_model.dart';

final authLocalDatasourceProvider = Provider<AuthLocalDatasource>((ref) {
  final hiveService = ref.read(hiveServiceProvider);
  final userSessionService = ref.read(userSessionServiceProvider);
  return AuthLocalDatasource(
    hiveService: hiveService,
    userSessionService: userSessionService,
  );
});

class AuthLocalDatasource implements IAuthLocalDatasource {
  final HiveService _hiveService;
  final UserSessionService _userSessionService;

  AuthLocalDatasource({
    required HiveService hiveService,
    required UserSessionService userSessionService,
  })  : _hiveService = hiveService,
        _userSessionService = userSessionService;

  @override
Future<AuthHiveModel?> login(String phoneNumber, String password) async {
  try {
    final user = await _hiveService.login(phoneNumber, password);

    if (user != null && user.authId != null) {
      // Save session correctly with all required fields
      await _userSessionService.saveUserSession(
        userId: user.authId!,
        fullname: user.fullName,     // must match service parameter
        email: user.email,
        address: user.address,
        phoneNumber: user.phoneNumber,
      );
    }

    return user;
  } catch (e) {
    return null;
  }
}

  @override
  Future<AuthHiveModel> register(AuthHiveModel model) async {
    return await _hiveService.registerUser(model);
  }

  @override
  Future<bool> isPhoneNumberExists(String phoneNumber) async {
    try {
      final exists =
          await _hiveService.isPhoneNumberExists(phoneNumber);
      return exists;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<AuthHiveModel?> getUserByPhoneNumber(String phoneNumber) async {
    try {
      final user =
          await _hiveService.getUserByPhoneNumber(phoneNumber);
      return user;
    } catch (e) {
      return null;
    }
  }
}

