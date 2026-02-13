import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

import "../../features/logo/business/repositories/logo_repository.dart";
import "../../features/logo/data/data_sources/local/logo_hive_data_source.dart";
import "../../features/logo/data/data_sources/local/logo_local_data_source.dart";
import "../../features/logo/data/data_sources/remote/logo_remote_data_source.dart";
import "../../features/logo/data/data_sources/remote/mock/logo_remote_data_mock.dart";
import "../../features/logo/data/models/tables/logo_table.dart";
import "../../features/logo/data/repositories/logo_repository_impl.dart";
import "../services/hive/hive_boxes.dart";
import "../services/hive/hive_registrar.g.dart";
import "instances_names.dart";

/// Class to inject the dependencies in the application
class CachedMemoryLogoDependencyInjection {
  /// Inject the services in the application
  static Future<void> init(
    Dio dio,
    Duration? toleranceRange, {
    bool? isMock,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();

    GetIt.I.registerSingleton<Duration>(
      toleranceRange ?? const Duration(days: 30), 
      instanceName: InstancesNames.durationInstance,
    );

    if (isMock ?? false) {
      _registerMockRepositories(
        toleranceRange: toleranceRange,
        errorPercentage: 0,
        maxWaitTime: 1000,
      );
    } else {
      _registerRemoteRepositories(dio, toleranceRange);
    }
    await registerServices();
  }

  static void _registerRemoteRepositories(
    Dio dio,
    Duration? toleranceRange,
  ) {
    GetIt.I.registerSingleton<LogoRepository>(
      LogoRepositoryImpl(
        localDataSource: LogoLocalDataSourceImpl(),
        hiveDataSource: LogoHiveDataSourceImpl(),
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
        localDataSource: LogoLocalDataSourceImpl(),
        hiveDataSource: LogoHiveDataSourceImpl(),
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
      // Hive
      await Hive.initFlutter();
      Hive.registerAdapters();
      await Hive.openBox<LogoTable>(logoBox);
    } catch (e) {
      rethrow;
    }
  }
}
