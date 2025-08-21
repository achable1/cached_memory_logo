import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../features/logo/business/repositories/logo_repository.dart";
import "../../features/logo/data/data_sources/local/keys/logo_local_data_keys.dart";
import "../../features/logo/data/data_sources/local/logo_local_data_source.dart";
import "../../features/logo/data/data_sources/remote/mock/logo_remote_data_mock.dart";
import "../../features/logo/data/repositories/logo_repository_impl.dart";

/// Class to inject the dependencies in the application
class DependencyInjection {
  /// Inject the services in the application
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    const errorPercentage = 0;
    const maxWaitTime = 2000;

    GetIt.I.registerSingleton<SharedPreferencesWithCache>(
      await SharedPreferencesWithCache.create(
        cacheOptions: SharedPreferencesWithCacheOptions(
          allowList: {
            ...LogoLocalDataKeys().keys,
          },
        ),
      ),
    );

    GetIt.I.registerSingleton<LogoRepository>(
      LogoRepositoryImpl(
        localDataSource: LogoLocalDataSourceImpl(
          localSource: GetIt.I<SharedPreferencesWithCache>(),
        ),
        remoteDataSource: LogoRemoteDataMock(
          errorPercentage: errorPercentage,
          maxWaitTime: maxWaitTime,
        ),
      ),
    );
  }
}
