import "dart:convert";

import "../../../business/entities/logo_entity.dart";

/// Model that transforms the Logo data from the API to the
/// application entity
class LogoModel extends LogoEntity {
  /// Model that transforms the Logo data from the API to the
  /// application entity
  const LogoModel({
    required super.path,
    required super.imageBase64,
    required super.monthSaved,
  });

  /// Factory method to create a Home model instance from a JSON
  factory LogoModel.fromJson({required String json}) =>
      LogoModel.fromMap(map: jsonDecode(json));

  /// Factory method to create a Logo model instance from a map
  factory LogoModel.fromMap({required Map<String, dynamic> map}) => LogoModel(
        path: map["path"] as String,
        imageBase64: map["imageBase64"] as String,
        monthSaved: map["monthSaved"] as int,
      );

  /// Factory method to create a Logo model instance from an
  /// entity
  factory LogoModel.fromEntity({required LogoEntity entity}) => LogoModel(
        path: entity.path,
        imageBase64: entity.imageBase64,
        monthSaved: entity.monthSaved,
      );

  /// Converts the Logo model instance to a map
  Map<String, dynamic> toMap() => {
        "path": path,
        "imageBase64": imageBase64,
        "monthSaved": monthSaved,
      };

  /// Converts the Home model instance to a JSON
  String toJson() => jsonEncode(toMap());

  /// Converts the Logo model instance to an entity
  LogoEntity toEntity() => LogoEntity(
        path: path,
        imageBase64: imageBase64,
        monthSaved: monthSaved,
      );
}
