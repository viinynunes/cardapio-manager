import 'package:cardapio_manager/src/modules/core/auth/domain/entities/user.dart';
import 'package:cardapio_manager/src/modules/core/auth/errors/user_errors.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/i_logged_user_repository.dart';
import '../i_logged_user_usecase.dart';

class LoggedUserUsecaseImpl implements ILoggedUserUsecase {
  final ILoggedUserRepository _repository;

  LoggedUserUsecaseImpl(this._repository);

  @override
  Future<Either<UserErrors, User>> getLoggedUser() async {
    return _repository.getLoggedUser();
  }

  @override
  Future<Either<UserErrors, bool>> logout() {
    return _repository.logout();
  }

  @override
  Future<Either<UserErrors, User>> saveLoggedUser(User user) async {
    if (user.id.isEmpty) {
      return Left(UserErrors('Invalid ID'));
    }

    if (user.enabled == false) {
      return Left(UserErrors('Cannot save a disabled user'));
    }

    return _repository.saveLoggedUser(user);
  }
}
