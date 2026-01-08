import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:internet_connection_checker_plus/internet_connection_checker_plus.dart";

import "../../features/logo/business/repositories/logo_repository.dart";
import "../../features/logo/data/data_sources/local/logo_local_data_source.dart";
import "../../features/logo/data/data_sources/remote/logo_remote_data_source.dart";
import "../../features/logo/data/data_sources/remote/mock/logo_remote_data_mock.dart";
import "../../features/logo/data/models/tables/logo_table.dart";
import "../../features/logo/data/repositories/logo_repository_impl.dart";
import "../services/connection/network_info.dart";
import "../services/hive/hive_boxes.dart";
import "../services/hive/hive_registrar.g.dart";
import "../services/logger/logger_service.dart";

/// Class to inject the dependencies in the application
class CachedMemoryLogoDependencyInjection {
  static final _logger = getLogger("CachedMemoryLogoDependencyInjection");

  /// Inject the services in the application
  static Future<void> init(
    Dio dio,
    Duration? toleranceRange, {
    bool? isMock,
  }) async {
    _logger.i("DependencyInjection.init - starting");
    WidgetsFlutterBinding.ensureInitialized();

    if (isMock ?? false) {
      _registerMockRepositories(
        toleranceRange: toleranceRange,
        errorPercentage: 0,
        maxWaitTime: 1000,
      );
    } else {
      _registerRemoteRepositories(dio, toleranceRange);
    }
    _logger.i("Registered LogoRepository with GetIt");
    await registerServices();
    _logger.i("DependencyInjection.init - done");
  }

  static void _registerRemoteRepositories(
    Dio dio,
    Duration? toleranceRange,
  ) {
    GetIt.I.registerSingleton<LogoRepository>(
      LogoRepositoryImpl(
        toleranceRange: toleranceRange ?? const Duration(days: 30),
        networkInfo: NetworkInfoImpl(
          InternetConnection(),
        ),
        localDataSource: LogoLocalDataSourceImpl(),
        remoteDataSource: LogoRemoteDataSourceImpl(
          dio: dio,
        ),
      ),
    );
  }

  static void _registerMockRepositories({
    required int errorPercentage,
    required int maxWaitTime,
    Duration? toleranceRange,
  }) {
    GetIt.I.registerSingleton<LogoRepository>(
      LogoRepositoryImpl(
        toleranceRange: toleranceRange ?? const Duration(days: 30),
        networkInfo: NetworkInfoImpl(
          InternetConnection(),
        ),
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
