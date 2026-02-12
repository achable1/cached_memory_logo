import "package:fpdart/fpdart.dart";

import "../../../../core/constants/classes/use_case.dart";
import "../../../../core/errors/failure.dart";
import "../../data/models/params/params.dart";
import "../repositories/logo_repository.dart";

/// Save logo use case to storage locally in the device
class SaveLogo extends UseCaseAsync<void, SaveLogoParams> {
  /// Save logo use case to storage locally in the device
  SaveLogo({required this.logoRepository});

  /// Logo repository collection
  final LogoRepository logoRepository;

  @override
  Future<Either<Failure, void>> call({
    required SaveLogoParams params,
  }) =>
      logoRepository.saveLogo(params: params);
}
