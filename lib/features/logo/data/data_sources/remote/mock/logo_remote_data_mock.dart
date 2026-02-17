import "../../../../../../core/constants/classes/mock_data_source.dart";
import "../../../models/params/logo_params.dart";
import "../logo_remote_data_source.dart";
import "dependencies/logo_mock_strings.dart";

/// Mock implementation of [LogoRemoteDataSource]
class LogoRemoteDataMock extends MockDataSource
    implements LogoRemoteDataSource {
  /// Constructor for [LogoRemoteDataMock]
  LogoRemoteDataMock({
    required super.errorPercentage,
    required super.maxWaitTime,
  });

  @override
  Future<String> getBase64Logo({
    required LogoParams params,
  }) async {
    await awaitableMethod();

    final String base64Logo = switch (params.path) {
      "logos/costco.png" => LogoMockStrings.costco,
      "logos/7-eleven.png" => LogoMockStrings.sevenEleven,
      "logos/mercado-pago.png" => LogoMockStrings.mercadoPago,
      "logos/paypal.png" => LogoMockStrings.payPal,
      "logos/one-card.png" => LogoMockStrings.oneCard,
      _ => LogoMockStrings.defaultGenericLogo
    };

    return base64Logo;
  }
}
