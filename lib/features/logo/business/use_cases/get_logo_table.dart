import "package:fpdart/fpdart.dart";

import "../../../../core/constants/classes/use_case.dart";
import "../../../../core/errors/failure.dart";
import "../../data/models/objects/logo_object.dart";
import "../../data/models/params/logo_params.dart";
import "../repositories/logo_repository.dart";

/// Get Logo Table Use Case by path value
class GetLogoTable extends UseCaseAsync<LogoObject?, LogoParams> {
  /// Get Logo Table Use Case by path value
  GetLogoTable({required this.logoRepository});

  /// Logo repository collection
  final LogoRepository logoRepository;

  @override
  Future<Either<Failure, LogoObject?>> call({
    required LogoParams params,
  }) =>
      logoRepository.getLogoTable(params: params);
}
