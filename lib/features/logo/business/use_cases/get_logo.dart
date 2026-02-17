import "dart:io";

import "package:fpdart/fpdart.dart";

import "../../../../core/constants/classes/use_case.dart";
import "../../../../core/errors/failure.dart";
import "../../../../core/services/logger/logger_service.dart";
import "../../data/models/params/params.dart";
import "../../data/models/tables/logo_table.dart";
import "../entities/logo_entity.dart";
import "../repositories/logo_repository.dart";
import "get_base_64_logo.dart";
import "get_logo_file.dart";
import "get_logo_table.dart";
import "save_logo.dart";

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
    final Logger logger = getLogger("GetLogo");
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
      logger.f("GetLogoTable failure: ${failure!.title}, ${failure!.message}");
      return Left(failure!);
    }

    final DateTime dateTime = (logoTable?.saved != null)
        ? DateTime.parse(logoTable!.saved)
        : DateTime(1969);

    final bool isOldLogo =
        dateTime.add(toleranceRange).isBefore(DateTime.now());

    if (logoTable == null || isOldLogo) {
      logger.d("LogoTable null or is old logo");

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
        logger
            .f("GetBase64Logo failure: ${failure!.title}, ${failure!.message}");
        return Left(failure!);
      }

      final saveLogoUseCase = await SaveLogo(
        logoRepository: logoRepository,
      ).call(
        params: SaveLogoParams(
          path: params.path,
          base64Logo: base64Logo,
        ),
      );

      saveLogoUseCase.fold(
        (l) {
          logger.f("SaveLogo failure: ${failure!.title}, ${failure!.message}");
          return failure = l;
        },
        (r) {
          logger.d("SaveLogo success, yay");
          r;
        },
      );

      if (failure != null) {
        logger.f("SaveLogo failure: ${failure!.title}, ${failure!.message}");
        return Left(failure!);
      }

      logger.d("GetLogo base64Logo returned");
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
        logger.f("GetLogoFile failure: ${failure!.title}, ${failure!.message}");
        return Left(failure!);
      }

      if (file != null) {
        logger.d("GetLogoFile fileLogo returned");
        return Right(LogoEntity(fileLogo: file));
      }
    }

    logger.d("GetLogo fallback return (empty)");
    return const Right(LogoEntity());
  }
}
