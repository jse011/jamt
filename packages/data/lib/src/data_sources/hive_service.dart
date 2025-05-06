import 'package:data/src/data_sources/table/table.dart';
import 'package:hive_flutter/adapters.dart';

class HiveService {
  static bool _initialized = false;
  static late Box<UserTable> _userBox;

  static Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter(); // Esto maneja Web y Móvil automáticamente
    Hive.registerAdapter(UserTableAdapter());

    _userBox = await Hive.openBox<UserTable>('users');
    _initialized = true;
  }

  static Box<UserTable> get userBox {
    if (!_initialized) {
      throw Exception('HiveService not initialized. Call init() first.');
    }
    return _userBox;
  }

  static bool get isInitialized => _initialized;
}