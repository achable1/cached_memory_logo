import "package:fpdart/fpdart.dart";

import "../../../../core/constants/classes/use_case.dart";
import "../../../../core/errors/failure.dart";
import "../../data/models/params/logo_params.dart";
import "../../data/models/tables/logo_table.dart";
import "../repositories/logo_repository.dart";

/// Get Logo Table Use Case by path value
class GetLogoTable extends UseCaseAsync<LogoTable?, LogoParams> {
  /// Get Logo Table Use Case by path value
  GetLogoTable({required this.logoRepository});

  /// Logo repository collection
  final LogoRepository logoRepository;

  @override
  Future<Either<Failure, LogoTable?>> call({
    required LogoParams params,
  }) =>
      logoRepository.getLogoTable(params: params);
}
