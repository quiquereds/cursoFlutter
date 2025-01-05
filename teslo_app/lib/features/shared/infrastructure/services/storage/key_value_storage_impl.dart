import 'package:shared_preferences/shared_preferences.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/storage/key_value_storage.dart';

/// Creamos una clase que implementa la interfaz [KeyValueStorageService] que
/// definimos anteriormente. Esta clase se utilizará para interactuar con el
/// paquete shared_preferences.
class KeyValueStorageServiceImpl extends KeyValueStorageService {
  // Creamos una instancia de SharedPreferences
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();

    // Se lee el valor (si existe) de acuerdo al tipo de dato haciendo un cast
    switch (T) {
      case String:
        return prefs.getString(key) as T?;

      case int:
        return prefs.getInt(key) as T?;

      case double:
        return prefs.getDouble(key) as T?;

      case bool:
        return prefs.getBool(key) as T?;

      case List:
        return prefs.getStringList(key) as T?;

      default:
        throw UnimplementedError(
            'Get not implemented for type ${T.runtimeType}');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();

    // Se almacena el valor de acuerdo al tipo de dato y haciendo un cast
    switch (T) {
      case String:
        await prefs.setString(key, value as String);
        break;
      case int:
        await prefs.setInt(key, value as int);
        break;
      case double:
        await prefs.setDouble(key, value as double);
        break;
      case bool:
        await prefs.setBool(key, value as bool);
        break;
      case List:
        await prefs.setStringList(key, value as List<String>);
        break;
      default:
        throw UnimplementedError(
            'Set not implemented for type ${T.runtimeType}');
    }
  }
}
