import "dart:convert";

import "../../../business/entities/home_entity.dart";

/// Model that transforms the Home data from the API to the
/// application entity
class HomeModel extends HomeEntity {
  /// Model that transforms the Home data from the API to the
  /// application entity
  const HomeModel();

  

  /// Factory method to create a Home model instance from a JSON
  factory HomeModel.fromJson({required String json}) => HomeModel.fromMap(map: jsonDecode(json));

  /// Factory method to create a Home model instance from a map
  factory HomeModel.fromMap({required Map<String, dynamic> map}) =>
     const HomeModel();

  /// Factory method to create a Home model instance from an 
  /// entity
  factory HomeModel.fromEntity({required HomeEntity entity}) => HomeModel();

  /// Converts the Home model instance to a map
  Map<String, dynamic> toMap() => {};

  /// Converts the Home model instance to a JSON
  String toJson() => jsonEncode(toMap());
  
  /// Converts the Home model instance to an entity
  HomeEntity toEntity() => HomeEntity();
}
