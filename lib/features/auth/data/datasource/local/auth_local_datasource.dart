import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/hive/hive_service.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/storage/token_service.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/storage/user_session_service.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/datasource/auth_datasource.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_hive_model.dart';

// Provider for AuthLocalDatasource
final authLocalDatasourceProvider = Provider<IAuthLocalDatasource>((ref) {
  final hiveService = ref.read(hiveServiceProvider);
  final userSessionService = ref.read(userSessionServiceProvider);
  return AuthLocalDatasource(
    hiveService: hiveService,
    userSessionService: userSessionService,
    tokenService: ref.read(tokenServiceProvider),
    );
});

class AuthLocalDatasource implements IAuthLocalDatasource {
  final HiveService _hiveService;
  final UserSessionService _userSessionService;
  final TokenService _tokenService;

  AuthLocalDatasource({
  required HiveService hiveService, 
  required UserSessionService userSessionService,
  required TokenService tokenService,
   }): _hiveService = hiveService,
   _userSessionService = userSessionService,
    _tokenService = tokenService;

    

  // Register user
  @override
  Future<AuthHiveModel> register (AuthHiveModel user) async {
    try {
      // Check if email already exists
      if (_hiveService.isEmailExists(user.email)) {
        throw Exception('Email already exists');
      }

      await _hiveService.registerUser(user);
      return user;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  //  return await _hiveService.register(user);


  }

  // Login user
  @override
  Future<AuthHiveModel?> login(String email, String password) async {
    // try {
    //   final user = await _hiveService.loginUser(email, password);
    //   return user;
    // } catch (e) {
    //   throw Exception('Login failed: $e');
    // }
    try {
      // final user = await _hiveService.login(email, password);
      final user =  _hiveService.login(email, password);
      if (user != null && user.authId != null) {
        // Save user session to sharedpreffs
        await _userSessionService.saveUserSession(
          userId: user.authId!,
          fullname: user.fullName,
          email: user.email,
          address: user.address,
          phoneNumber: user.phoneNumber, 
          profileImage: null,
          // profileImage: user.profileImage,
          
        );
      }
      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }




  
  @override
  Future<bool> logout() async {
    try{
      await _userSessionService.clearSession();
      await _tokenService.removeToken();
      return true;
    }catch (e) {
      return false;
    }
  }
  
  @override
  // Future<AuthHiveModel?> getCurrentUser() async {
  //   try {
  //     final users = _hiveService.getAllAuths();
  //     if (users.isNotEmpty) {
  //       return users.first;
  //     }
  //     return null;
  //   } catch (e) {
  //     throw Exception('Failed to get current user: $e');
  //   }
  // }
  Future<AuthHiveModel?> getCurrentUser() async {
    try {
      // Check if user is logged in
      if (!_userSessionService.isLoggedIn()) {
        return null;
      }

      // Get user ID from session
      final userId = _userSessionService.getCurrentUserId();
      if (userId == null) {
        return null;
      }

      // Fetch user from Hive database
      return _hiveService.getUserById(userId);
    } catch (e) {
      return null;
    }
  }

  // @override
  // Future<bool> clearAllUserData() async {
  //   try {
  //     await _hiveService.deleteAllAuths();
  //     // yedi chaiyo bhani aaru deta halne
  //     // await _hiveService.deleteAllPosts();
  //     // await _hiveService.deleteAllComments();
  //     return true;
  //   } catch (e) {
  //     throw Exception('Failed to clear user data: $e');
  //   }
  // }

  // @override
  // Future<bool> isEmailExists(String email) {
  //   try {
  //     final exists = _hiveService.isEmailExists(email);
  //     return Future.value(exists);
  //   } catch (e) {
  //     return Future.value(false);
  //   }
  // }

  @override
  Future<bool> deleteUser(String authId) async {
    try {
      await _hiveService.deleteUser(authId);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<AuthHiveModel?> getUserByEmail(String email) async {
    try {
      return _hiveService.getUserByEmail(email);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<AuthHiveModel?> getUserById(String authId) async {
    try {
      return _hiveService.getUserById(authId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> updateUser(AuthHiveModel user) async {
    try {
      return await _hiveService.updateUser(user);
    } catch (e) {
      return false;
    }
  }


  
}


