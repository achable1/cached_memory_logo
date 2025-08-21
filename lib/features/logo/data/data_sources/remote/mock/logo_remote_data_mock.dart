import "../../../../../../core/constants/classes/mock_data_source.dart";
import "../../../../../../core/services/logger/logger_service.dart";
import "../../../models/params/logo_params.dart";
import "../logo_remote_data_source.dart";

/// Mock implementation of [LogoRemoteDataSource]
class LogoRemoteDataMock extends MockDataSource
    implements LogoRemoteDataSource {
  /// Constructor for [LogoRemoteDataMock]
  LogoRemoteDataMock({
    required super.errorPercentage,
    required super.maxWaitTime,
  });

  @override
  Logger get logger => getLogger("CTT Remote Data Mock");

  final _base64Logo = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUA";

  @override
  Future<String> getBase64Logo({
    required LogoParams params,
  }) async {
    await awaitableMethod();

    logger.i("Fetched base64 logo: $_base64Logo");

    return _base64Logo;
  }
}
