import '../../../domain/entities/client.dart';

abstract class ClientEvents {}

class GetClientListEvent implements ClientEvents {}

class CreateOrUpdateClientEvent implements ClientEvents {
  final Client client;

  CreateOrUpdateClientEvent(this.client);
}

class DisableClient implements ClientEvents {
  final Client client;

  DisableClient(this.client);
}

class FilterClientListByTextEvent implements ClientEvents {
  final List<Client> clientList;
  final String searchText;

  FilterClientListByTextEvent(this.clientList, this.searchText);
}
