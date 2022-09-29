import 'package:cardapio_manager/src/modules/core/auth/infra/datasources/i_login_datasource.dart';
import 'package:cardapio_manager/src/modules/core/auth/infra/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginFirebaseDatasourceImpl implements ILoginDatasource {
  User? _firebaseUser;
  Map<String, dynamic> _userData = {};

  @override
  Future<UserModel> login(String email, String password) async {
    final loginResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError(
          (e) => throw Exception(e.toString()),
        );

    _firebaseUser = loginResult.user;

    _userData = {};

    await _loadCurrentUser();

    return UserModel.fromMap(_userData);
  }

  Future<void> _loadCurrentUser() async {
    _firebaseUser = FirebaseAuth.instance.currentUser;

    if (_firebaseUser != null) {
      if (_userData['name'] == null) {
        final docUser = await FirebaseFirestore.instance
            .collection('users')
            .doc(_firebaseUser!.uid)
            .get();

        _userData = docUser.data() as Map<String, dynamic>;
        _userData['id'] = docUser.id;
      }
    }
  }
}
