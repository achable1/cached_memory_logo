import '../../../../../core/constants/classes/params.dart';

/// Parameters used to make the Home request.
class HomeParams extends Params {
  /// Parameters used to make the Home request.
  HomeParams();
  
  

  @override
  Map<String, dynamic> headers() => {
        "Authorization": "Bearer $accessToken",
      };

  @override
  Map<String, dynamic>? queries() => null;

  @override
  Map<String, dynamic> body() => {};
}