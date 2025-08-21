import "package:fpdart/fpdart.dart";

import "../../../../core/constants/classes/use_case.dart";
import "../../../../core/errors/failure.dart";
import "../../data/models/params/logo_params.dart";
import "../repositories/logo_repository.dart";

/// Use case for getting the base64 logo, first part of the flow
class GetBase64Logo implements UseCaseAsync<String, LogoParams> {

  /// Constructor for [GetBase64Logo]
  GetBase64Logo({required this.logoRepository});

  /// Repository for getting logo information
  final LogoRepository logoRepository;

  @override
  Future<Either<Failure, String>> call({
    required LogoParams params,
  }) async {
    throw UnimplementedError(); // TODO: implement call
  }

  @override
  Failure? failure;
}
