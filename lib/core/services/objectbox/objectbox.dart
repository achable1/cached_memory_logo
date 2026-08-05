import "dart:io";

import "package:get_it/get_it.dart";
import "package:path/path.dart" as p;
import "object_boxes.dart";
import "objectbox.g.dart";

/// Helper class to handle the creation of local database ObjectBox
class ObjectBox {
  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// The Store of this app.
  late final Store store;

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = GetIt.I<Directory>();
    final store =
        await openStore(directory: p.join(docsDir.path, logoBox));
    return ObjectBox._create(store);
  }
}
