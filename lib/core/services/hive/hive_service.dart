// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hamro_bhagaicha_batch35d/core/config/hive_table_constant.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_hive_model.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';

// final hiveServiceProvider = Provider<HiveService>((ref) {
//   return HiveService();
// });

// class HiveService {
//   /// Initialize Hive
//   Future<void> init() async {
//     final directory = await getApplicationDocumentsDirectory();
//     Hive.init(directory.path);

//     _registerAdapters();
//     await _openBoxes();
//   }

//     /// Register adapters
//   void _registerAdapters() {
//     if (!Hive.isAdapterRegistered(HiveTableConstant.authTypeId)) {
//       Hive.registerAdapter(AuthHiveModelAdapter());
//     }
//   }

//  /// Open boxes
//   Future<void> _openBoxes() async {
//     await Hive.openBox<AuthHiveModel>(HiveTableConstant.authTable);
//   }


// // auth
// Box<AuthHiveModel> get _authBox =>
//      Hive.box<AuthHiveModel>(HiveTableConstant.authTable);

//      Future<AuthHiveModel> registerUser(AuthHiveModel model) async {
//       await _authBox.put(model.authId, model);
//       return model;
//      }


//  // login user
// Future<AuthHiveModel?> loginUser(String email, String password) async {
//   final users = _authBox.values.where(
//     (user) => user.email == email && user.password == password,
//   );
//   if(users.isNotEmpty) {
//     return users.first;
//   }
//   return null;
// }    


// // get current user
// AuthHiveModel? getCurrentUser(String authId) {
//   return _authBox.get(authId);
// }

//  }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/config/hive_table_constant.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_hive_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());

class HiveService {
  Box<AuthHiveModel>? _authBox;

  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    _registerAdapters();
    await _openBoxes();
  }

  void _registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveTableConstant.authTypeId)) {
      Hive.registerAdapter(AuthHiveModelAdapter());
    }
  }

  Future<void> _openBoxes() async {
    _authBox = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authTable);
  }

  Future<void> registerUser(AuthHiveModel user) async {
    if (_authBox == null) return;
    await _authBox!.put(user.email.trim().toLowerCase(), user);
  }

  Future<AuthHiveModel?> loginUser(String email, String password) async {
    if (_authBox == null) return null;
    final user = _authBox!.get(email.trim().toLowerCase());
    if (user != null && user.password.trim() == password.trim()) {
      return user;
    }
    return null;
  }

  AuthHiveModel? getCurrentUser(String authId) {
    if (_authBox == null) return null;
    return _authBox!.get(authId);
  }
}
