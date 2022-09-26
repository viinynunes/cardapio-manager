import 'package:cardapio_manager/src/modules/core/client/infra/models/client_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../infra/datasources/client_datasource.dart';

class ClientFirebaseDatasourceImpl implements IClientDatasource {
  final _clientCollection = FirebaseFirestore.instance.collection('clients');

  @override
  Future<ClientModel> create(ClientModel client) async {
    final signUpClient = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: client.email,
            password: '@#&@@(())5newUserResetPassword@%676@')
        .catchError((e) => throw Exception(e.toString()));

    signUpClient.user != null
        ? client.id = signUpClient.user!.uid
        : throw Exception('Invalid new user ID');

    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: client.email)
        .catchError((e) => throw Exception(e.toString()));

    await _clientCollection
        .doc(client.id)
        .set(client.toMap())
        .catchError((e) => throw Exception(e.toString()));

    await _clientCollection
        .doc(client.id)
        .update(client.toMap())
        .catchError((e) => throw Exception(e.toString()));

    return client;
  }

  @override
  Future<ClientModel> update(ClientModel client) async {
    await _clientCollection
        .doc(client.id)
        .update(client.toMap())
        .catchError((e) => throw Exception(e.toString()));

    final recClientOrders = await FirebaseFirestore.instance
        .collection('orders')
        .where('client.id', isEqualTo: client.id)
        .get();

    for (var order in recClientOrders.docs) {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(order.id)
          .update({'client': client.toMap()});

      await FirebaseFirestore.instance
          .collection('clients')
          .doc(client.id)
          .collection('orders')
          .doc(order.id)
          .update({'client': client.toMap()});
    }

    return client;
  }

  @override
  Future<bool> disable(ClientModel client) {
    // TODO: implement disable
    throw UnimplementedError();
  }

  @override
  Future<List<ClientModel>> findAll() async {
    List<ClientModel> clientList = [];

    final clientSnap =
        await _clientCollection.orderBy('name', descending: true).get();

    for (var client in clientSnap.docs) {
      clientList.add(ClientModel.fromMap(client.data()));
    }

    return clientList;
  }
}
