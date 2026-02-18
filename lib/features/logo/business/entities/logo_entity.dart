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

  /// Is empty getter value
  bool get isEmpty => fileLogo == null && base64Logo == null;

  /// Is file getter value
  bool get isFile => fileLogo != null;

  /// Is base 64 getter value
  bool get isBase64 => base64Logo != null;

  /// Fold operation to handle different states of entity
  T fold<T>(
    T Function(File file) onFile,
    T Function(String base64) onBase64,
    T Function() onEmpty,
  ) {
    if (fileLogo != null) {
      return onFile(fileLogo!);
    }
    if (base64Logo != null) {
      return onBase64(base64Logo!);
    }
    return onEmpty();
  }

  @override
  List<Object?> get props => [fileLogo, base64Logo];
}
