import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/config/hive_table_constant.dart';
import 'package:hamro_bhagaicha_batch35d/core/constants/hive_table_constants.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_hive_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider<HiveService>((ref) {
  return HiveService();
});

class HiveService {
  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/${HiveTableConstants.dbName}';
    Hive.init(path);
    _registerAdapters();
    await _openBoxes();
  }

  void _registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveTableConstant.authTypeId)) {
      Hive.registerAdapter(AuthHiveModelAdapter());
    }
  }

  Future<void> _openBoxes() async {
    await Hive.openBox<AuthHiveModel>(HiveTableConstant.authTable);
  }

  Box<AuthHiveModel> get _authBox =>
      Hive.box<AuthHiveModel>(HiveTableConstant.authTable);

  // ==================== Auth Queries ====================

  Future<AuthHiveModel> registerUser(AuthHiveModel model) async {
    try {
      await _authBox.put(model.authId, model);
      return model;
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  Future<AuthHiveModel?> loginUser(String email, String password) async {
    try {
      final users = _authBox.values.where(
        (user) => user.email == email && user.password == password,
      );
      if (users.isNotEmpty) {
        return users.first;
      }
      return null;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<void> logoutUser() async {
    try {
      await _authBox.clear();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<void> deleteAllAuths() async {
    try {
      await _authBox.clear();
    } catch (e) {
      throw Exception('Failed to delete all auths: $e');
    }
  }

  List<AuthHiveModel> getAllAuths() {
    try {
      return _authBox.values.toList();
    } catch (e) {
      throw Exception('Failed to get all auths: $e');
    }
  }

  AuthHiveModel? getCurrentUser(String authId) {
    try {
      return _authBox.get(authId);
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  bool isEmailExists(String email) {
    try {
      final users = _authBox.values.where((user) => user.email == email);
      return users.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> close() async {
    await Hive.close();
  }

  Future<void> logout() async {}

  Future<AuthHiveModel> register(AuthHiveModel user) async {
    await _authBox.put(user.authId, user);
    return user;
  }

// Login - find user by email and password
AuthHiveModel? login(String email, String password) {
  try{
    return _authBox.values.firstWhere(
      (user) => user.email == email && user.password == password,
    );
  }catch (e) {
    return null;
  }
}

AuthHiveModel? getUserById(String authId) {
    return _authBox.get(authId);
  }

  // Get user by email
  AuthHiveModel? getUserByEmail(String email) {
    try {
      return _authBox.values.firstWhere((user) => user.email == email);
    } catch (e) {
      return null;
    }
  }

  // Update user
  Future<bool> updateUser(AuthHiveModel user) async {
    if (_authBox.containsKey(user.authId)) {
      await _authBox.put(user.authId, user);
      return true;
    }
    return false;
  }

  // Delete user
  Future<void> deleteUser(String authId) async {
    await _authBox.delete(authId);
  }
}