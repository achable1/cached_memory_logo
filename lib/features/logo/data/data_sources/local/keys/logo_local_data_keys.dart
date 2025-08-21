import "../../../../../../core/constants/classes/local_data_source_keys.dart";

/// Keys for the local data source for the logo process
class LogoLocalDataKeys implements LocalDataSourceKeys {
  /// Key for knowing the type of logo
  static const logoType = "LOGO_TYPE";

  @override
  Set<String> get keys => {
        logoType,
      };
}
