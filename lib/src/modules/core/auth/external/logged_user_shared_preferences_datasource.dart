import 'package:shared_preferences/shared_preferences.dart';

import '../infra/datasources/i_logged_user_datasource.dart';
import '../infra/models/user_model.dart';

class LoggedUserSharedPreferencesDatasource implements ILoggedUserDatasource {
  @override
  Future<UserModel> getLoggedUser() async {
    final userPref = await SharedPreferences.getInstance();

    return UserModel.fromJson(userPref.get('User') as String);
  }

  @override
  Future<bool> logout() async {
    final userPref = await SharedPreferences.getInstance();

    await userPref.remove('User');

    return true;
  }

  @override
  Future<UserModel> saveLoggedUser(UserModel user) async {
    final userPref = await SharedPreferences.getInstance();

    await userPref.setString('User', user.toJson());

    final recUser = UserModel.fromJson(userPref.get('User') as String);

    return recUser;
  }
}
