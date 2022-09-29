abstract class LoginEvents {}

class LoginEvent implements LoginEvents {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}