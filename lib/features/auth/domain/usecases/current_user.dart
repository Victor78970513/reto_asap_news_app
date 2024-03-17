import 'package:dartz/dartz.dart';
import 'package:reto_asap/core/error/failures.dart';
import 'package:reto_asap/core/usecase/use_case.dart';
import 'package:reto_asap/features/auth/domain/repository/auth_repository.dart';
import 'package:reto_asap/core/entities/user.dart';

// Caso de uso para obtener el usuario actualmente autenticado
class CurrentUser implements UseCase<PortalNewsUser, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, PortalNewsUser>> call(NoParams params) async {
    // Llama al método del repositorio para obtener el usuario actual
    return await authRepository.currentUser();
  }
}
