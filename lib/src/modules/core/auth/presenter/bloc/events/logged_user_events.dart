import 'package:cardapio_manager/src/modules/core/auth/domain/entities/user.dart';

abstract class LoggedUserEvents {}

class GetLoggedUserEvent implements LoggedUserEvents {}

class SaveLoggedUserEvent implements LoggedUserEvents {
  final User user;

  SaveLoggedUserEvent(this.user);
}

class LogoutLoggedUserEvent implements LoggedUserEvents {}
