import "../../../business/entities/logo_entity.dart";

/// Logo model used for the return type of the GetLogo Use Case
class LogoModel extends LogoEntity {
  /// Logo model used for the return type of the GetLogo Use Case
  const LogoModel({
    super.fileLogo,
    super.base64Logo,
  });
}
