import "package:equatable/equatable.dart";

/// Entity that contains the data of the Logo.
class LogoEntity extends Equatable {
  /// Entity that contains the data of the Logo.
  const LogoEntity({
    required this.path,
    required this.imageBase64,
    required this.monthSaved,
  });

  /// Path of the logo within the fetchUrl
  final String path;

  /// Base64 encoded image data of the logo
  final String imageBase64;

  /// Month when the logo was saved/consulted
  final int monthSaved;

  @override
  List<Object?> get props => [
        path,
        imageBase64,
        monthSaved,
      ];

  @override
  bool get stringify => true;
}
