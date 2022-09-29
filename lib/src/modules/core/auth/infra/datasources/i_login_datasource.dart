import '../models/user_model.dart';

abstract class ILoginDatasource {
  Future<UserModel> login(String email, String password);
}
