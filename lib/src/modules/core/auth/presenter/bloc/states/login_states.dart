import 'package:cardapio_manager/src/modules/core/auth/domain/entities/user.dart';
import 'package:cardapio_manager/src/modules/core/auth/errors/user_errors.dart';

abstract class LoginStates {}

class LoginIdleState implements LoginStates {}

class LoginLoadingState implements LoginStates {}

class LoginSuccessState implements LoginStates {
  final User user;

  LoginSuccessState(this.user);
}

class LoginErrorState implements LoginStates {
  final UserErrors error;

  LoginErrorState(this.error);
}
