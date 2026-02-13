import "dart:io";

import "package:fpdart/fpdart.dart";

import "../../../../core/constants/classes/use_case.dart";
import "../../../../core/errors/failure.dart";
import "../../data/models/params/logo_params.dart";
import "../../data/models/tables/logo_table.dart";
import "../entities/logo_entity.dart";
import "../repositories/logo_repository.dart";
import "get_base_64_logo.dart";
import "get_logo_file.dart";
import "get_logo_table.dart";

/// Retrieves a file logo, whetever if its fetched in remote, or if its locally storaged
class GetLogo extends UseCaseAsync<LogoEntity, LogoParams> {
  /// Retrieves a file logo, whetever if its fetched in remote, or if its locally storaged
  GetLogo({
    required this.logoRepository,
    required this.toleranceRange,
  });

  /// Logo repository collection
  final LogoRepository logoRepository;

  /// Represents the difference between the saved DateTime and the time that you want to fetch again remote logo data,
  /// this automatically sets for 30 days, but, for testing or development flows, you can set into less time
  final Duration toleranceRange;

  @override
  Future<Either<Failure, LogoEntity>> call({
    required LogoParams params,
  }) async {
    LogoTable? logoTable;
    Failure? failure;
    File? file;

    final getLogoFileNameUseCase = await GetLogoTable(
      logoRepository: logoRepository,
    ).call(
      params: params,
    );

    getLogoFileNameUseCase.fold(
      (l) => failure = l,
      (r) => logoTable = r,
    );

    if (failure != null) {
      return Left(failure!);
    }

    final DateTime dateTime = (logoTable?.saved != null)
        ? DateTime.parse(logoTable!.saved)
        : DateTime(1969);

    final bool isOldLogo =
        dateTime.add(toleranceRange).isBefore(DateTime.now());

    if (logoTable == null || isOldLogo) {
      String? base64Logo;

      final getBase64LogoUseCase = await GetBase64Logo(
        logoRepository: logoRepository,
      ).call(
        params: params,
      );

      getBase64LogoUseCase.fold(
        (l) => failure = l,
        (r) => base64Logo = r,
      );

      if (failure != null) {
        return Left(failure!);
      }

      return Right(LogoEntity(base64Logo: base64Logo));
    } else {
      final getLogoFileUseCase = await GetLogoFile(
        logoRepository: logoRepository,
      ).call(
        params: logoTable!.fileName,
      );

      getLogoFileUseCase.fold(
        (l) => failure = l,
        (r) => file = r,
      );

      if (failure != null) {
        return Left(failure!);
      }

      if (file != null) {
        return Right(LogoEntity(fileLogo: file));
      }
    }

    return const Right(LogoEntity());
  }
}
