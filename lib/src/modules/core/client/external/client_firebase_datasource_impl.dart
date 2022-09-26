import 'package:cardapio_manager/src/modules/core/client/infra/models/client_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../infra/datasources/client_datasource.dart';

class ClientFirebaseDatasourceImpl implements IClientDatasource {
  final _clientCollection = FirebaseFirestore.instance.collection('clients');

  @override
  Future<ClientModel> create(ClientModel client) async {
    final recClient = await _clientCollection.add(client.toMap());

    client.id = recClient.id;

    await _clientCollection.doc(client.id).update(client.toMap());

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: client.email, password: 'newUserResetPassword@%676@');

    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: client.email.trim());

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
