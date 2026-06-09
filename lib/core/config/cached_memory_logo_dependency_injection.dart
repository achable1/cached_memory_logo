import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

import "../../features/logo/business/entities/dependencies/device_storage_validator.dart";
import "../../features/logo/business/entities/dependencies/device_storage_validator_impl.dart";
import "../../features/logo/business/repositories/logo_repository.dart";
import "../../features/logo/data/data_sources/local/logo_hive_data_source.dart";
import "../../features/logo/data/data_sources/local/logo_local_data_source.dart";
import "../../features/logo/data/data_sources/remote/logo_remote_data_source.dart";
import "../../features/logo/data/data_sources/remote/mock/logo_remote_data_mock.dart";
import "../../features/logo/data/models/tables/logo_table.dart";
import "../../features/logo/data/repositories/logo_repository_impl.dart";
import "../../package_init_params.dart";
import "../services/hive/cached_memory_logo_adapters.dart";
import "../services/hive/hive_boxes.dart";
import "instances_names.dart";
import "storage_config.dart";

/// Class to inject the dependencies in the application
class CachedMemoryLogoDependencyInjection {
  /// Inject the services in the application
  static Future<void> init({
    required PackageInitParams params,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();

    if (params.isMock ?? false) {
      _registerMockRepositories(
        toleranceRange: params.toleranceRange,
        errorPercentage: 0,
        maxWaitTime: 1000,
      );
    } else {
      _registerRemoteRepositories(
        dio: params.dio,
      );
    }

    await registerServices(
      toleranceRange: params.toleranceRange,
      config: StorageConfig(
        minFreeSpaceMB: params.minFreeSpaceMB ?? 50,
        safetyMarginMB: params.safetyMarginMB ?? 500,
      ),
    );
  }

  static void _registerRemoteRepositories({
    required Dio dio,
  }) {
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
  static Future<void> registerServices({
    required StorageConfig config,
    Duration? toleranceRange,
  }) async {
    await _hiveServices();
    await _miscServices(
      config: config,
      toleranceRange: toleranceRange,
    );
  }

  static Future _hiveServices() async {
    await Hive.initFlutter("hive/cached_memory_logo");
    await CachedMemoryLogoAdapters.init();
    await Hive.openLazyBox<LogoTable>(
      logoBox,
    );
  }

  static Future _miscServices({
    required StorageConfig config,
    Duration? toleranceRange,
  }) async {
    GetIt.I.registerSingleton<Duration>(
      toleranceRange ?? const Duration(days: 30),
      instanceName: InstancesNames.durationInstance,
    );

    GetIt.I.registerSingleton<DeviceStorageValidator>(
      DeviceStorageValidatorImpl(
        config: config,
      ),
    );
  }
}
