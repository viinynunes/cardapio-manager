import 'package:cardapio_manager/src/modules/core/auth/domain/entities/user.dart';
import 'package:cardapio_manager/src/modules/core/auth/domain/repositories/i_login_repository.dart';
import 'package:cardapio_manager/src/modules/core/auth/errors/user_errors.dart';
import 'package:dartz/dartz.dart';

import '../datasources/i_login_datasource.dart';

class LoginRepositoryImpl implements ILoginRepository {
  final ILoginDatasource _userDatasource;

  LoginRepositoryImpl(this._userDatasource);

  @override
  Future<Either<UserErrors, User>> login(String email, String password) async {
    try {
      final result = await _userDatasource.login(email, password);

      return Right(result);
    } catch (e) {
      return Left(UserErrors(e.toString()));
    }
  }
}
