/// [LocalDataSourceKeys] is a class that contains all the keys used in the local data source.
///
/// This class is used to avoid using hardcoded strings in the local data source.
/// Also it is a way for using [SharedPreferencesWithCache] keys in a more organized way.
abstract class LocalDataSourceKeys {
  /// Returns a map with all the keys used in the local data source.
  Set<String> get keys;
}
