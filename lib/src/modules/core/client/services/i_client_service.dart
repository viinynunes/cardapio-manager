import '../domain/entities/client.dart';

abstract class IClientService {
  List<Client> filterClientByText(List<Client> clientList, String searchText);
}
