// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hamro_bhagaicha_batch35d/core/config/hive_table_constant.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_hive_model.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';

// final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());

// class HiveService {
//   Box<AuthHiveModel>? _authBox;

//   Future<void> init() async {
//     final directory = await getApplicationDocumentsDirectory();
//     Hive.init(directory.path);

//     _registerAdapters();
//     await _openBoxes();
//   }

//   void _registerAdapters() {
//     if (!Hive.isAdapterRegistered(HiveTableConstant.authTypeId)) {
//       Hive.registerAdapter(AuthHiveModelAdapter());
//     }
//   }

//   Future<void> _openBoxes() async {
//     _authBox ??= await Hive.openBox<AuthHiveModel>(HiveTableConstant.authTable);
//   }

//   /// ===================== Auth Methods =====================

//    Future<AuthHiveModel> registerUser(AuthHiveModel user) async {
//     if (_authBox == null) throw Exception('Hive box not initialized');
//     // Using phoneNumber as key
//     await _authBox!.put(user.phoneNumber, user);
//     return user;
//   }

//   Future<AuthHiveModel?> loginUser(String email, String password) async {
//   if (_authBox == null) return null;

//   AuthHiveModel? user;

//   // Iterate over all users to find match
//   for (final u in _authBox!.values) {
//     if (u.email.toLowerCase() == email.toLowerCase() && u.password == password) {
//       user = u;
//       break;
//     }
//   }

//   return user;
// }

//   Future<bool> isPhoneNumberExists(String phoneNumber) async {
//     if (_authBox == null) return false;
//     return _authBox!.containsKey(phoneNumber);
//   }

//   Future<AuthHiveModel?> getUserByPhoneNumber(String phoneNumber) async {
//     if (_authBox == null) return null;
//     return _authBox!.get(phoneNumber);
//   }
// }


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
}