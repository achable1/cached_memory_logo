import "dart:convert" show base64Decode;
import "dart:io";

import "package:disk_space_2/disk_space_2.dart";
import "package:fpdart/fpdart.dart";
import "package:get_it/get_it.dart";
import "package:path_provider/path_provider.dart";

import "../../../../core/constants/classes/use_case.dart";
import "../../../../core/errors/failure.dart";
import "../../../../core/services/logger/logger_service.dart";
import "../../data/models/params/params.dart";
import "../../data/models/tables/logo_table.dart";
import "../entities/logo_entity.dart";
import "../repositories/logo_repository.dart";
import "use_cases.dart";

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

    if (logoTable != null && isOldLogo) {
      final deleteLogoUseCase = await DeleteLogo(
        logoRepository: GetIt.I<LogoRepository>(),
      ).call(
        params: DeleteLogoParams(
          path: logoTable?.path,
          fileName: logoTable?.fileName,
        ),
      );

      deleteLogoUseCase.fold(
        (l) {
          // Log failure but don't block the refetch flow
          logger.w(
            "DeleteLogo warning: ${l.title}, ${l.message}; Continuing with refetch",
          );
        },
        (r) => r,
      );

      // Reset logoTable to null to refetch, regardless of delete success
      logoTable = null;
    }

    if (logoTable == null || isOldLogo) {
      logger.i(
        "LogoTable null or is old logo, needed to fetch",
      );

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

      final dir = await getApplicationDocumentsDirectory();
      final freeDeviceSpaceMiB =
          await DiskSpace.getFreeDiskSpaceForPath(dir.path);

      // 1 MB is approximately 0.9537 MiB, DiskSpace returns MiB, so we transform here
      final freeDeviceSpaceMB = (freeDeviceSpaceMiB ?? 0) / 0.9537;

      // Check byte lenght of base 64 value; Bytes to KB, and KB to MB
      final decodedBytes = base64Decode(base64Logo!);
      final weightOfFileMB = decodedBytes.length / (1024 * 1024);

      // 50MB + Aprox. MB file size + 500 MB safety margin for system sizes calculation
      final spaceMargin = 50 + weightOfFileMB + 500;

      if (freeDeviceSpaceMB < spaceMargin) {
        logger.d(
          "GetLogo base64Logo returned, because not enough space within margin",
        );
        return Right(LogoEntity(base64Logo: base64Logo));
      }

      final saveLogoUseCase = await SaveLogo(
        logoRepository: logoRepository,
      ).call(
        params: SaveLogoParams(
          path: params.path,
          bytes: decodedBytes,
        ),
      );

      saveLogoUseCase.fold(
        (l) => failure = l,
        (r) {
          logger.i("SaveLogo success!");
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
        logger.i("GetLogoFile local fileLogo returned");
        return Right(LogoEntity(fileLogo: file));
      }
    }

    logger.i("GetLogo fallback return (empty)");
    return const Right(LogoEntity());
  }
}
