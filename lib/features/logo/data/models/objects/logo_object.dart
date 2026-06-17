import "package:objectbox/objectbox.dart";

/// An object that stores logo data for local data base
@Entity()
class LogoObject {
  /// Creates a new instance of [LogoObject].
  LogoObject({
    required this.path,
    required this.fileName,
    required this.saved,
    this.id = 0,
  });

  /// Identificator of the entry in DB
  @Id()
  int id;

  /// Path of the logo within the fetchUrl
  String path;

  /// File name of the saved image in app storage
  String fileName;

  /// String representation of the DateTime when logo was saved into local database
  String saved;
}
