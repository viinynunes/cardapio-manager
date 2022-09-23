import 'package:cardapio_manager/src/modules/core/client/infra/models/client_model.dart';

abstract class IClientDatasource {
  Future<ClientModel> create(ClientModel client);

  Future<ClientModel> update(ClientModel client);

  Future<bool> disable(ClientModel client);

  Future<List<ClientModel>> finalAll();
}