import "package:dio/dio.dart";

import "../../models/params/logo_params.dart";

/// Remote data source for the Logo collection
// ignore: one_member_abstracts
abstract class LogoRemoteDataSource {
  /// Gets the base64 logo string
  Future<String> getBase64Logo({
    required LogoParams params,
  });
}

/// Remote data source for the Logo collection
class LogoRemoteDataSourceImpl implements LogoRemoteDataSource {
  /// Remote data source for the Logo collection
  LogoRemoteDataSourceImpl({required this.dio});

  /// Dio adapter instance
  final Dio dio;

  @override
  Future<String> getBase64Logo({required LogoParams params}) async {
    final response = await dio.get(
      params.path,
      options: Options(
        headers: params.headers(),
      ),
    );

    return response.data["Data"];
  }
}
