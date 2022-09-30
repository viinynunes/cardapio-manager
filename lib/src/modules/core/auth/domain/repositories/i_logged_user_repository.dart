import 'package:cardapio_manager/src/modules/core/auth/domain/entities/user.dart';
import 'package:cardapio_manager/src/modules/core/auth/errors/user_errors.dart';
import 'package:dartz/dartz.dart';

abstract class ILoggedUserRepository {
  Future<Either<UserErrors, User>> getLoggedUser();

  Future<Either<UserErrors, User>> saveLoggedUser(User user);

  Future<Either<UserErrors, bool>> logout();
}
