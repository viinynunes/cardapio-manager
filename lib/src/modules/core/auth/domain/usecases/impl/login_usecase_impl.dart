import 'package:cardapio_manager/src/modules/core/auth/domain/entities/user.dart';
import 'package:cardapio_manager/src/modules/core/auth/domain/repositories/i_login_repository.dart';
import 'package:cardapio_manager/src/modules/core/auth/domain/usecases/i_login_usecase.dart';
import 'package:cardapio_manager/src/modules/core/auth/errors/user_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:string_validator/string_validator.dart';

class LoginUsecaseImpl implements ILoginUsecase {
  final ILoginRepository _userRepository;

  LoginUsecaseImpl(this._userRepository);

  @override
  Future<Either<UserErrors, User>> login(String email, String password) async {
    if (!isEmail(email)) {
      return Left(UserErrors('Invalid email'));
    }

    if (password.length < 6) {
      return Left(UserErrors('Invalid password'));
    }

    return _userRepository.login(email, password);
  }

  @override
  Future<Either<UserErrors, bool>> logout() async {
    return _userRepository.logout();
  }

}
