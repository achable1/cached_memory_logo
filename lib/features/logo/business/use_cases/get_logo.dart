import "dart:io";

import "package:fpdart/fpdart.dart";

import "../../../../core/constants/classes/use_case.dart";
import "../../../../core/errors/failure.dart";
import "../../data/models/params/logo_params.dart";
import "../entities/logo_entity.dart";
import "../repositories/logo_repository.dart";
import "get_base_64_logo.dart";
import "get_logo_file.dart";
import "get_logo_file_name.dart";

/// Retrieves a file logo, whetever if its fetched in remote, or if its locally storaged
class GetLogo extends UseCaseAsync<LogoEntity, LogoParams> {
  /// Retrieves a file logo, whetever if its fetched in remote, or if its locally storaged
  GetLogo({required this.logoRepository});

  /// Logo repository collection
  final LogoRepository logoRepository;

  @override
  Future<Either<Failure, LogoEntity>> call({
    required LogoParams params,
  }) async {
    String? fileName;
    Failure? failure;
    File? file;

    final getLogoFileNameUseCase = await GetLogoFileName(
      logoRepository: logoRepository,
    ).call(
      params: params,
    );

    getLogoFileNameUseCase.fold(
      (l) => failure = l, 
      (r) => fileName = r,
    );

    if (failure != null) {
      return Left(failure!);
    }

    if (fileName != null) {
      final getLogoFileUseCase = await GetLogoFile(
        logoRepository: logoRepository,
      ).call(
        params: fileName!,
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
    } else {
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
    }

    return const Right(LogoEntity());
  }
}
