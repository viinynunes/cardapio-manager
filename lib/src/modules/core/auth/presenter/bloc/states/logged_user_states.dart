import 'package:cardapio_manager/src/modules/core/auth/errors/user_errors.dart';

import '../../../domain/entities/user.dart';

abstract class LoggedUserStates {}

class LoggedUserIdleState implements LoggedUserStates {}

class LoggedUserLoadingState implements LoggedUserStates {}

class LoggedUserSuccessState implements LoggedUserStates {
  final User user;

  LoggedUserSuccessState(this.user);
}

class LoggedUserErrorState implements LoggedUserStates {
  final UserErrors error;

  LoggedUserErrorState(this.error);
}
