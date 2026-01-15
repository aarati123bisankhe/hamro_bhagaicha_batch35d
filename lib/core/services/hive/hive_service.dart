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

  // ✅ REGISTER USER
  Future<AuthHiveModel> registerUser(AuthHiveModel user) async {
    if (_authBox == null) {
      throw Exception('Auth box not initialized');
    }
    await _authBox!.put(user.phoneNumber, user);
    return user;
  }

  // ✅ LOGIN USER
  Future<AuthHiveModel?> login(String phoneNumber, String password) async {
    if (_authBox == null) return null;

    final user = _authBox!.get(phoneNumber);
    if (user != null && user.password.trim() == password.trim()) {
      return user;
    }
    return null;
  }

  // ✅ CHECK IF PHONE NUMBER EXISTS
  Future<bool> isPhoneNumberExists(String phoneNumber) async {
    if (_authBox == null) return false;
    return _authBox!.containsKey(phoneNumber);
  }

  // ✅ GET USER BY PHONE NUMBER
  Future<AuthHiveModel?> getUserByPhoneNumber(String phoneNumber) async {
    if (_authBox == null) return null;
    return _authBox!.get(phoneNumber);
  }

  // ✅ GET CURRENT USER (OPTIONAL)
  AuthHiveModel? getCurrentUser(String phoneNumber) {
    if (_authBox == null) return null;
    return _authBox!.get(phoneNumber);
  }
}

