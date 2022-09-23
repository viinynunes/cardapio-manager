import 'package:cardapio_manager/src/modules/core/client/domain/entities/client.dart';
import 'package:cardapio_manager/src/modules/core/client/errors/client_errors.dart';
import 'package:dartz/dartz.dart';

abstract class IClientRepository {
  Future<Either<ClientErrors, Client>> create(Client client);

  Future<Either<ClientErrors, Client>> update(Client client);

  Future<Either<ClientErrors, bool>> disable(Client client);

  Future<Either<ClientErrors, List<Client>>> finalAll();
}
