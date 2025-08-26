import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

import "../../features/logo/business/repositories/logo_repository.dart";
import "../../features/logo/data/data_sources/local/logo_local_data_source.dart";
import "../../features/logo/data/data_sources/remote/mock/logo_remote_data_mock.dart";
import "../../features/logo/data/models/tables/logo_table.dart";
import "../../features/logo/data/repositories/logo_repository_impl.dart";
import "../services/hive/hive_boxes.dart";
import "../services/hive/hive_registrar.g.dart";

/// Class to inject the dependencies in the application
class DependencyInjection {
  /// Inject the services in the application
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await registerServices();

    const errorPercentage = 0;
    const maxWaitTime = 2000;

    GetIt.I.registerSingleton<LogoRepository>(
      LogoRepositoryImpl(
        localDataSource: LogoLocalDataSourceImpl(),
        remoteDataSource: LogoRemoteDataMock(
          errorPercentage: errorPercentage,
          maxWaitTime: maxWaitTime,
        ),
      ),
    );
  }

  /// Registers the services for the application
  static Future<void> registerServices() async {
    // Hive
    await Hive.initFlutter();
    Hive.registerAdapters();
    await Hive.openBox<LogoTable>(logoBox);
  }

}
