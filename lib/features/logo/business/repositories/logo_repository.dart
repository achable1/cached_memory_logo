// ignore_for_file: one_member_abstracts

import "package:fpdart/fpdart.dart";

import "../../../../core/errors/failure.dart";
import "../../data/models/params/logo_params.dart";

/// Data operations for the Logo collection
abstract class LogoRepository {
  /// Fetches the base64 encoded image of the logo.
  Future<Either<Failure, String>> getBase64Image({
    required LogoParams params,
  });
}
