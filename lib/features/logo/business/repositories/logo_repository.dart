// ignore_for_file: one_member_abstracts

import "package:fpdart/fpdart.dart";

import "../../../../core/constants/classes/params.dart";
import "../../../../core/errors/failure.dart";

/// Data operations for the Logo collection
abstract class LogoRepository {
  /// Fetches the base64 encoded image of the logo.
  Future<Either<Failure, String>> getBase64Image({
    required NoParams params,
  });
}
