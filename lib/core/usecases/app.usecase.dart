import 'package:dartz/dartz.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
// import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';

abstract interface class UsecaseWithParams<SuccessType, Params> {
   Future<Either<Failure, SuccessType>> call(Params params);
}

abstract interface class UsecaseWithoutParams<SuccessType> {
   Future<Either<Failure, SuccessType>> call();
}