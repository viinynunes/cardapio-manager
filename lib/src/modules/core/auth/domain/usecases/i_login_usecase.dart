import 'package:dartz/dartz.dart';

import '../../errors/user_errors.dart';
import '../entities/user.dart';

abstract class ILoginUsecase {
  Future<Either<UserErrors, User>> login(String email, String password);

  Future<Either<UserErrors, bool>> logout();
}
