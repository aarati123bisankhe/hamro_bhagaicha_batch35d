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

  /// Initialize Hive
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

  /// Register user
  Future<bool> registerUser(AuthHiveModel model) async {
    if (_authBox == null) return false;
    try {
      await _authBox!.put(model.email, model); // use email as key
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Login user
  Future<AuthHiveModel?> loginUser(String email, String password) async {
    if (_authBox == null) return null;
    try {
      final user = _authBox!.get(email);
      if (user != null && user.password == password) return user;
      return null;
    } catch (e) {
      return null;
    }
  }
}
