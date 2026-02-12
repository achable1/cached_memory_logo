import "dart:io" show File;

import "package:equatable/equatable.dart";

/// Logo entity used for the return type of the GetLogo Use Case
class LogoEntity extends Equatable {
  /// Logo entity used for the return type of the GetLogo Use Case
  const LogoEntity({this.fileLogo, this.base64Logo});

  /// File logo value
  final File? fileLogo;

  /// Base 64 String value
  final String? base64Logo;
  
  @override
  List<Object?> get props => [fileLogo, base64Logo];
}
