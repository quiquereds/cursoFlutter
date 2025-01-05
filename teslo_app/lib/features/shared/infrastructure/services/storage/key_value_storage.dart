/// Creamos una clase abstracta que nos permitirá definir los métodos que se
/// utilizarán para guardar, obtener y eliminar valores en el almacenamiento
/// local de la aplicación. Este método permitirá alternar entre diferentes
/// implementaciones de almacenamiento local, como SharedPreferences o Hive.
///
/// T es un tipo genérico que se utilizará para definir el tipo de valor que
/// se almacenará en el almacenamiento local. Por ejemplo, si se desea almacenar
/// un valor de tipo String, se utilizará el tipo genérico String.
abstract class KeyValueStorageService {
  /// Este método se utilizará para guardar un valor en el almacenamiento local.
  /// La función maneja un tipo genérico T que se utilizará para definir el tipo
  /// de valor que se almacenará en el almacenamiento local.
  Future<void> setKeyValue<T>(String key, T value);

  /// Este método se utilizará para obtener un valor del almacenamiento local.
  /// La función recibe un tipo genérico T opcional.
  Future<T?> getValue<T>(String key);

  /// Este método se utilizará para eliminar un valor del almacenamiento local.
  Future<bool> removeKey(String key);
}
