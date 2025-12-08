import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

import "../services/logger/logger_service.dart";

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
    final logger = getLogger("DependencyInjection");
    logger.i("DependencyInjection.init - starting");
    WidgetsFlutterBinding.ensureInitialized();

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
    logger.i("Registered LogoRepository with GetIt");
    await registerServices();
    logger.i("DependencyInjection.init - done");
  }

  /// Registers the services for the application
  static Future<void> registerServices() async {
    final logger = getLogger("DependencyInjection");
    try {
      logger.i("registerServices - starting");
      // Hive
      await Hive.initFlutter();
      logger.i("Hive initialized");
      Hive.registerAdapters();
      logger.i("Hive adapters registered");
      await Hive.openBox<LogoTable>(logoBox);
      logger.i("Opened Hive box: $logoBox");
    } catch (e, s) {
      logger.e("Error registering services: $e\n$s");
      rethrow;
    }
  }
}
