import "package:fpdart/fpdart.dart";
import "package:get_it/get_it.dart";

import "../../../../core/config/instances_names.dart";
import "../../../../core/errors/failure.dart";
import "../../../../core/services/logger/logger_service.dart";
import "../../business/entities/dependencies/device_storage_validator.dart";
import "../../business/entities/logo_entity.dart";
import "../../business/repositories/logo_repository.dart";
import "../../business/use_cases/get_or_refresh_logo.dart";
import "../../business/use_cases/use_cases.dart";
import "../../data/models/params/logo_params.dart";
import "get_info_cubit.dart";

/// A cubit that manages the state of the logo.
class LogoCubit extends GetInfoCubit<LogoEntity> {
  /// Creates a [LogoCubit].
  LogoCubit({
    required this.params,
  });

  /// The parameters for the logo.
  final LogoParams params;

  @override
  Future<Either<Failure, LogoEntity>> callUseCase() async {
    try {
      final logoRepository = GetIt.I.get<LogoRepository>();
      final result = await GetOrRefreshLogo(
        logoRepository: logoRepository,
        toleranceRange: GetIt.I.get<Duration>(
          instanceName: InstancesNames.durationInstance,
        ),
        deleteLogoUseCase: DeleteLogo(
          logoRepository: logoRepository,
        ),
        getBase64LogoUseCase: GetBase64Logo(
          logoRepository: logoRepository,
        ),
        getLogoFileUseCase: GetLogoFile(
          logoRepository: logoRepository,
        ),
        getLogoTableUseCase: GetLogoTable(
          logoRepository: logoRepository,
        ),
        saveLogoUseCase: SaveLogo(
          logoRepository: logoRepository,
        ),
        storageValidator: GetIt.I<DeviceStorageValidator>(),
      ).call(
        params: params,
      );
      final logger = getLogger("LogoCubit");
      return result.fold(
        Left.new,
        (r) {
          try {
            return Right(r);
          } catch (e, s) {
            logger.e(
              "Failed to base64Decode for path=${params.path} | error: $e \n$s",
            );
            return Left(
              AppFailure.unexpected(
                "El string no es un formato válido de base64",
              ),
            );
          }
        },
      );
    } catch (e) {
      return Left(AppFailure.unexpected(e.toString()));
    }
  }
}
