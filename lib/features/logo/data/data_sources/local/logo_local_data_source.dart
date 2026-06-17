import "../../../../../core/services/objectbox/objectbox.g.dart";
import "../../models/objects/logo_object.dart";

/// Hive data source for the Logo collection
abstract class LogoLocalDataSource {
  /// Fetches a logo by its path from the hive database.
  Future<LogoObject?> getLogoTable(String path);

  /// Saves a logo to the Hive database.
  int saveLogo(LogoObject logo);

  /// Deletes a logo from the Hive database.
  bool deleteLogo(int id);
}

/// Hive data source for the Logo collection
class LogoLocalDataSourceImpl implements LogoLocalDataSource {
  /// Hive data source for the Logo collection
  LogoLocalDataSourceImpl({
    required this.logoBox,
  });

  /// Logo box where logos are storaged in ObjectBox
  final Box<LogoObject> logoBox;

  /// Fetches a logo by its path from the Hive database.
  @override
  Future<LogoObject?> getLogoTable(String path) async {
    final query = (logoBox.query(LogoObject_.path.equals(path))
          ..order(LogoObject_.path))
        .build();
    final results = query.find();
    final logoObject = results.first;
    query.close();

    return logoObject;
  }

  /// Saves a logo within the local database.
  @override
  int saveLogo(LogoObject logo) => logoBox.put(logo);

  /// Deletes a logo within the local database.
  @override
  bool deleteLogo(int id) => logoBox.remove(id);
}
