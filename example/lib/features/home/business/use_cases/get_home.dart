import "package:fpdart/fpdart.dart";

import "../../../../core/constants/classes/use_case.dart";
import "../../../../core/errors/failure.dart";
import "../../data/models/params/home_params.dart";
import "../entities/home_entity.dart";
import "../repositories/home_repository.dart";

class GetHome implements UseCase<HomeEntity, HomeParams> {
  final HomeRepository homeRepository;

  GetHome({required this.homeRepository});

  @override
  Future<Either<Failure, HomeEntity>> call({
    required HomeParams params,
  }) {
    
    // TODO: implement call
    throw UnimplementedError();
    
    
  }
}
