import 'package:cardapio_manager/src/modules/core/client/domain/entities/client.dart';
import 'package:cardapio_manager/src/modules/core/client/services/i_client_service.dart';

class ClientServiceImpl implements IClientService {
  @override
  List<Client> filterClientByText(List<Client> clientList, String searchText) {
    if (clientList.isEmpty) {
      return clientList;
    }

    List<Client> filteredList = [];

    for (var client in clientList) {
      if (client.name.toLowerCase().contains(searchText.toLowerCase()) ||
          client.email.toLowerCase().contains(searchText.toLowerCase()) ||
          client.phone.toLowerCase().contains(searchText.toLowerCase())) {
        filteredList.add(client);
      }
    }

    return filteredList;
  }
}
