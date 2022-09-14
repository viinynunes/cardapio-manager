import 'package:cardapio_manager/src/modules/core/client/domain/entities/client.dart';

class ClientModel extends Client {
  ClientModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
  });

  ClientModel.fromClient(Client client)
      : super(
          id: client.id,
          name: client.name,
          email: client.email,
          phone: client.phone,
        );

  ClientModel.fromMap(Map<String, dynamic> map)
      : super(
          id: map['id'],
          name: map['name'],
          email: map['email'],
          phone: map['phone'],
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
