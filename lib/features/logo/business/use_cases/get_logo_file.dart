import "dart:io" show File;

import "package:fpdart/fpdart.dart";

import "../../../../core/constants/classes/use_case.dart";
import "../../../../core/errors/failure.dart";
import "../repositories/logo_repository.dart";

/// Use case to Gets a fileName with a path provided in the local device
class GetLogoFile extends UseCaseAsync<File, String> {
  /// Use case to Gets a fileName with a path provided in the local device
  GetLogoFile({required this.logoRepository});

  /// Logo repository collection
  final LogoRepository logoRepository;

  @override
  Future<Either<Failure, File>> call({
    required String params,
  }) => logoRepository.getLogoFile(fileName: params);
}
