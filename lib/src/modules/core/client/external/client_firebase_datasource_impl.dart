import 'package:cardapio_manager/src/modules/core/client/infra/models/client_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../infra/datasources/client_datasource.dart';

class ClientFirebaseDatasourceImpl implements IClientDatasource {
  final _clientCollection = FirebaseFirestore.instance.collection('clients');

  @override
  Future<ClientModel> create(ClientModel client) async {
/*    final recClient = await _clientCollection.add(client.toMap());

    client.id = recClient.id;

    await _clientCollection.doc(client.id).update(client.toMap());

    return client;*/

    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<ClientModel> update(ClientModel client) {
    // TODO: implement update
    throw UnimplementedError();
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