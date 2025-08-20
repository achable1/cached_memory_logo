import "package:fpdart/fpdart.dart";

import "../../../../core/constants/classes/use_case.dart";
import "../../../../core/errors/failure.dart";
import "../../data/models/params/logo_params.dart";
import "../entities/logo_entity.dart";
import "../repositories/logo_repository.dart";

class GetLogo implements UseCase<LogoEntity, LogoParams> {
  final LogoRepository logoRepository;

  GetLogo({required this.logoRepository});

  @override
  Future<Either<Failure, LogoEntity>> call({
    required LogoParams params,
  }) {
    
    // TODO: implement call
    throw UnimplementedError();
    
    
  }
}
