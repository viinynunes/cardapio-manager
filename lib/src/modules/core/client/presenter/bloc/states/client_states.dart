import 'package:cardapio_manager/src/modules/core/client/errors/client_errors.dart';

import '../../../domain/entities/client.dart';

abstract class ClientStates {}

class ClientIdleState implements ClientStates {}

class ClientLoadingState implements ClientStates {}

class ClientSuccessState implements ClientStates {}

class ClientGetListSuccessState implements ClientStates {
  final List<Client> clientList;

  ClientGetListSuccessState(this.clientList);
}

class ClientCreateOrUpdateSuccessState implements ClientStates {
  final Client client;

  ClientCreateOrUpdateSuccessState(this.client);
}

class ClientErrorState implements ClientStates {
  final ClientErrors error;

  ClientErrorState(this.error);
}
