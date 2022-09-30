import '../models/user_model.dart';

abstract class ILoggedUserDatasource {
  Future<UserModel> getLoggedUser();

  Future<UserModel> saveLoggedUser(UserModel user);

  Future<bool> logout();
}
