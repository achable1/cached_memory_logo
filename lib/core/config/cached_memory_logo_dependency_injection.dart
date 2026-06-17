import "dart:io";

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:objectbox/objectbox.dart";
import "package:path_provider/path_provider.dart";

import "../../features/logo/business/entities/dependencies/device_storage_validator.dart";
import "../../features/logo/business/entities/dependencies/device_storage_validator_impl.dart";
import "../../features/logo/business/repositories/logo_repository.dart";
import "../../features/logo/data/data_sources/local/logo_file_data_source.dart";
import "../../features/logo/data/data_sources/local/logo_local_data_source.dart";
import "../../features/logo/data/data_sources/remote/logo_remote_data_source.dart";
import "../../features/logo/data/data_sources/remote/mock/logo_remote_data_mock.dart";
import "../../features/logo/data/models/objects/logo_object.dart";
import "../../features/logo/data/repositories/logo_repository_impl.dart";
import "../services/logger/logger_service.dart";
import "../services/objectbox/objectbox_config.dart";
import "instances_names.dart";
import "storage_config.dart";

/// Class to inject the dependencies in the application
class CachedMemoryLogoDependencyInjection {
  /// Logger of the class
  static Logger logger = getLogger("CachedMemoryLogoDependencyInjection");

  /// Inject the services in the application
  static Future<void> init(
    Dio dio,
    Duration? toleranceRange, {
    StorageConfig? storageConfig,
    bool? isMock,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();

    await registerServices(toleranceRange, storageConfig: storageConfig);

    if (isMock ?? false) {
      _registerMockRepositories(
        toleranceRange: toleranceRange,
        errorPercentage: 0,
        maxWaitTime: 1000,
      );
    } else {
      _registerRemoteRepositories(dio, toleranceRange);
    }
  }

  /// Registers the services for the application
  static Future<void> registerServices(
    Duration? toleranceRange, {
    StorageConfig? storageConfig,
  }) async {
    logger.i("Registering services...");
    final docsDir = await getApplicationDocumentsDirectory();

    GetIt.I.registerSingleton<Directory>(
      docsDir,
    );

    await _localDatabasesServices();
    await _miscServices(toleranceRange, clientStorageConfig: storageConfig);
  }

  static Future _localDatabasesServices() async {
    logger.i("Registering local database services...");
    final ObjectBox logoObjectBox = await ObjectBox.create();
    GetIt.I.registerSingleton<Store>(
      logoObjectBox.store,
    );
    GetIt.I.registerSingleton<Box<LogoObject>>(
      GetIt.I<Store>().box<LogoObject>(),
    );
  }

  static Future _miscServices(
    Duration? toleranceRange, {
    StorageConfig? clientStorageConfig,
  }) async {
    logger.i("Registering misc services...");

    GetIt.I.registerSingleton<Duration>(
      toleranceRange ?? const Duration(days: 30),
      instanceName: InstancesNames.durationInstance,
    );

    final storageConfig = clientStorageConfig ?? const StorageConfig();

    GetIt.I.registerSingleton<StorageConfig>(storageConfig);

    GetIt.I.registerSingleton<DeviceStorageValidator>(
      DeviceStorageValidatorImpl(
        minFreeSpaceMB: storageConfig.minFreeSpaceMB,
        safetyMarginMB: storageConfig.safetyMarginMB,
      ),
    );
  }

  static void _registerRemoteRepositories(
    Dio dio,
    Duration? toleranceRange,
  ) {
    logger.i("Registering remote repositories...");

    GetIt.I.registerSingleton<LogoRepository>(
      LogoRepositoryImpl(
        logoFileDataSource: LogoFileDataSourceImpl(),
        logoLocalDataSource: LogoLocalDataSourceImpl(
          logoBox: GetIt.I<Box<LogoObject>>(),
        ),
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
    logger.i("Registering mock repositories...");

    GetIt.I.registerSingleton<LogoRepository>(
      LogoRepositoryImpl(
        logoFileDataSource: LogoFileDataSourceImpl(),
        logoLocalDataSource: LogoLocalDataSourceImpl(
          logoBox: GetIt.I<Box<LogoObject>>(),
        ),
        remoteDataSource: LogoRemoteDataMock(
          errorPercentage: errorPercentage,
          maxWaitTime: maxWaitTime,
        ),
      ),
    );
  }
}
