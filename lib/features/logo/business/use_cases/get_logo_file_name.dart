import "package:fpdart/fpdart.dart";

import "../../../../core/constants/classes/use_case.dart";
import "../../../../core/errors/failure.dart";
import "../../data/models/params/logo_params.dart";
import "../repositories/logo_repository.dart";

/// Get Logo Use Case by fileName value
class GetLogoFileName extends UseCaseAsync<String?, LogoParams> {
  /// Get Logo Use Case by fileName value
  GetLogoFileName({required this.logoRepository});

  /// Logo repository collection
  final LogoRepository logoRepository;

  @override
  Future<Either<Failure, String?>> call({
    required LogoParams params,
  }) => logoRepository.getLogoFileName(params: params);
}
