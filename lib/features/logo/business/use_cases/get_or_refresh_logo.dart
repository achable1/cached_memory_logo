import "dart:convert" show base64Decode;
import "dart:io";

import "package:fpdart/fpdart.dart";

import "../../../../core/constants/classes/use_case.dart";
import "../../../../core/errors/failure.dart";
import "../../../../core/services/logger/logger_service.dart";
import "../../data/models/objects/logo_object.dart";
import "../../data/models/params/params.dart";
import "../entities/cached_logo_entity.dart";
import "../entities/dependencies/device_storage_validator.dart";
import "../entities/logo_entity.dart";
import "../repositories/logo_repository.dart";
import "use_cases.dart";

/// Retrieves a file logo, whetever if its fetched in remote, or if its locally storaged;
/// validates the life time of each logo, deletes if the range doesn't apply, and can
/// refetche to updated version within time
class GetOrRefreshLogo extends UseCaseAsync<LogoEntity, LogoParams> {
  /// Retrieves a file logo, whetever if its fetched in remote, or if its locally storaged;
  /// validates the life time of each logo, deletes if the range doesn't apply, and can
  /// refetche to updated version within time
  GetOrRefreshLogo({
    required this.logoRepository,
    required this.toleranceRange,
    required this.getLogoTableUseCase,
    required this.deleteLogoUseCase,
    required this.getBase64LogoUseCase,
    required this.saveLogoUseCase,
    required this.getLogoFileUseCase,
    required this.storageValidator,
  });

  /// Logo repository collection
  final LogoRepository logoRepository;

  /// Represents the difference between the saved DateTime and the time that you want to fetch again remote logo data,
  /// this automatically sets for 30 days, but, for testing or development flows, you can set into less time
  final Duration toleranceRange;

  /// Get logo table use case dependency
  final GetLogoTable getLogoTableUseCase;

  /// Delete logo use case dependency
  final DeleteLogo deleteLogoUseCase;

  /// Get base 64 logo use case dependency
  final GetBase64Logo getBase64LogoUseCase;

  /// Save logo use case dependency
  final SaveLogo saveLogoUseCase;

  /// Get logo file use case dependency
  final GetLogoFile getLogoFileUseCase;

  /// Device storage validator object that are used to check within use case
  final DeviceStorageValidator storageValidator;

  @override
  Future<Either<Failure, LogoEntity>> call({
    required LogoParams params,
  }) async {
    final Logger logger = getLogger("GetLogo");

    LogoObject? logoTable;
    File? file;

    final getLogoTable = await getLogoTableUseCase.call(
      params: params,
    );

    getLogoTable.fold(
      (failure) {
        logger.f("GetLogoTable failure: ${failure.title}, ${failure.message}");
        return Left(failure);
      },
      (logoTableFolded) => logoTable = logoTableFolded,
    );

    final cachedLogoEntity = CachedLogoEntity(
      data: logoTable,
      toleranceRange: toleranceRange,
    );

    if (logoTable != null && cachedLogoEntity.isExpired()) {
      final deleteLogo = await deleteLogoUseCase.call(
        params: DeleteLogoParams(
          id: logoTable?.id ?? 0,
          path: logoTable?.path,
          fileName: logoTable?.fileName,
        ),
      );

      deleteLogo.fold(
        (failure) {
          logger.w(
            "DeleteLogo warning: ${failure.title}, ${failure.message}; Continuing with refetch",
          );
          return Left(failure);
        },
        (voidValue) {
          // Done!
        },
      );

      logoTable = null;
    }

    if (logoTable == null || cachedLogoEntity.isExpired()) {
      logger.i(
        "LogoTable null or is old logo, needed to fetch",
      );

      String? base64Logo;

      final getBase64 = await getBase64LogoUseCase.call(
        params: params,
      );

      getBase64.fold(
        (failure) {
          logger.f(
            "GetBase64Logo failure: ${failure.title}, ${failure.message}",
          );
          return Left(failure);
        },
        (base64LogoFolded) => base64Logo = base64LogoFolded,
      );

      final decodedBytes = base64Decode(base64Logo!);

      if (!await storageValidator.hasEnoughSpace(decodedBytes.length)) {
        logger.d(
          "GetLogo base64Logo returned, because not enough space within margin",
        );
        return Right(LogoEntity(base64Logo: base64Logo));
      }

      final saveLogo = await saveLogoUseCase.call(
        params: SaveLogoParams(
          path: params.path,
          bytes: decodedBytes,
        ),
      );

      saveLogo.fold(
        (failure) {
          logger.f("SaveLogo failure: ${failure.title}, ${failure.message}");
          return Left(failure);
        },
        (voidActionResult) {
          logger.i("SaveLogo success!");
        },
      );

      logger.d("GetLogo base64Logo returned");
      return Right(LogoEntity(base64Logo: base64Logo));
    } else {
      final getLogoFile = await getLogoFileUseCase.call(
        params: logoTable!.fileName,
      );

      getLogoFile.fold(
        (failure) {
          logger.f("GetLogoFile failure: ${failure.title}, ${failure.message}");
          return Left(failure);
        },
        (fileFolded) => file = fileFolded,
      );

      if (file != null) {
        logger.i("GetLogoFile local fileLogo returned");
        return Right(LogoEntity(fileLogo: file));
      }
    }

    logger.i("GetLogo fallback return (empty)");
    return const Right(LogoEntity());
  }
}
