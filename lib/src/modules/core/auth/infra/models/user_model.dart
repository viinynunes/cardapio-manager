import 'package:cardapio_manager/src/modules/core/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.enabled});

  UserModel.fromUser(User user)
      : super(
          id: user.id,
          name: user.name,
          email: user.email,
          enabled: user.enabled,
        );

  UserModel.fromMap(Map<String, dynamic> map)
      : super(
          id: map['id'],
          name: map['name'],
          email: map['email'],
          enabled: map['enabled'],
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'enabled': enabled,
    };
  }
}
