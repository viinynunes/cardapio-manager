import 'package:cardapio_manager/src/modules/core/client/infra/models/client_model.dart';

import '../infra/datasources/client_datasource.dart';

class ClientFirebaseDatasourceImpl implements IClientDatasource {
  @override
  Future<ClientModel> create(ClientModel client) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> disable(ClientModel client) {
    // TODO: implement disable
    throw UnimplementedError();
  }

  @override
  Future<List<ClientModel>> finalAll(ClientModel client) {
    // TODO: implement finalAll
    throw UnimplementedError();
  }

  @override
  Future<ClientModel> update(ClientModel client) {
    // TODO: implement update
    throw UnimplementedError();
  }

}