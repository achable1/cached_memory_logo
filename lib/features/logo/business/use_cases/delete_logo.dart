import "package:fpdart/fpdart.dart";

import "../../../../core/constants/classes/use_case.dart";
import "../../../../core/errors/failure.dart";
import "../../data/models/params/delete_logo_params.dart";
import "../repositories/logo_repository.dart";

/// Delete logo use case to erase a logo from the hive and device storage
class DeleteLogo extends UseCaseAsync<void, DeleteLogoParams> {
  /// Delete logo use case to erase a logo from the hive and device storage
  DeleteLogo({required this.logoRepository});

  /// Logo repository collection
  final LogoRepository logoRepository;

  @override
  Future<Either<Failure, void>> call({
    required DeleteLogoParams params,
  }) =>
      logoRepository.deleteLogo(params: params);
}
