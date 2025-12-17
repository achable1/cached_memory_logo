import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

import "../../features/logo/business/repositories/logo_repository.dart";
import "../../features/logo/data/data_sources/local/logo_local_data_source.dart";
import "../../features/logo/data/data_sources/remote/logo_remote_data_source.dart";
import "../../features/logo/data/models/tables/logo_table.dart";
import "../../features/logo/data/repositories/logo_repository_impl.dart";
import "../services/hive/hive_boxes.dart";
import "../services/hive/hive_registrar.g.dart";
import "../services/logger/logger_service.dart";

/// Class to inject the dependencies in the application
class CachedMemoryLogoDependencyInjection {

  static final _logger = getLogger("CachedMemoryLogoDependencyInjection");

  /// Inject the services in the application
  static Future<void> init(Dio dio) async {
    _logger.i("DependencyInjection.init - starting");
    WidgetsFlutterBinding.ensureInitialized();

    GetIt.I.registerSingleton<LogoRepository>(
      LogoRepositoryImpl(
        localDataSource: LogoLocalDataSourceImpl(),
        remoteDataSource: LogoRemoteDataSourceImpl(
          dio: dio,
        ),
      ),
    );
    _logger.i("Registered LogoRepository with GetIt");
    await registerServices();
    _logger.i("DependencyInjection.init - done");
  }

  /// Registers the services for the application
  static Future<void> registerServices() async {
    try {
      _logger.i("registerServices - starting");
      // Hive
      await Hive.initFlutter();
      _logger.i("Hive initialized");
      Hive.registerAdapters();
      _logger.i("Hive adapters registered");
      await Hive.openBox<LogoTable>(logoBox);
      _logger.i("Opened Hive box: $logoBox");
    } catch (e, s) {
      _logger.e("Error registering services: $e\n$s");
      rethrow;
    }
  }
}
