import 'package:dartz/dartz.dart';
import 'package:reto_asap/core/error/failures.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
