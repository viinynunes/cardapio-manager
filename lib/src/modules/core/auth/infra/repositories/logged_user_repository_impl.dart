import 'package:dartz/dartz.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/i_logged_user_repository.dart';
import '../../errors/user_errors.dart';
import '../datasources/i_logged_user_datasource.dart';
import '../models/user_model.dart';

class LoggedUserRepositoryImpl implements ILoggedUserRepository {
  final ILoggedUserDatasource _datasource;

  LoggedUserRepositoryImpl(this._datasource);

  @override
  Future<Either<UserErrors, User>> getLoggedUser() async {
    try {
      final result = await _datasource.getLoggedUser();

      return Right(result);
    } on UserErrors catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UserErrors('Uncaught Exception'));
    }
  }

  @override
  Future<Either<UserErrors, bool>> logout() async {
    try {
      final result = await _datasource.logout();

      return Right(result);
    } on UserErrors catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UserErrors('Uncaught Exception'));
    }
  }

  @override
  Future<Either<UserErrors, User>> saveLoggedUser(User user) async {
    try {
      final result = await _datasource.saveLoggedUser(UserModel.fromUser(user));

      return Right(result);
    } on UserErrors catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UserErrors('Uncaught Exception'));
    }
  }
}
