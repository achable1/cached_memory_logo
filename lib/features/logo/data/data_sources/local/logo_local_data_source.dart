import "package:shared_preferences/shared_preferences.dart";

/// Local data source for the Logo collection
abstract class LogoLocalDataSource {}

/// Local data source for the Logo collection
class LogoLocalDataSourceImpl implements LogoLocalDataSource {
  /// Local data source for the Logo collection
  LogoLocalDataSourceImpl({required this.localSource});

  /// Shared preferences instance
  final SharedPreferencesWithCache localSource;

}
