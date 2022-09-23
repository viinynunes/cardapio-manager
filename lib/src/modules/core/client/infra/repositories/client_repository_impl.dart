import 'package:cardapio_manager/src/modules/core/client/domain/entities/client.dart';
import 'package:cardapio_manager/src/modules/core/client/domain/repositories/client_repository.dart';
import 'package:cardapio_manager/src/modules/core/client/errors/client_errors.dart';
import 'package:cardapio_manager/src/modules/core/client/infra/datasources/client_datasource.dart';
import 'package:dartz/dartz.dart';

class ClientRepositoryImpl implements IClientRepository {
  final IClientDatasource _datasource;

  ClientRepositoryImpl(this._datasource);

  @override
  Future<Either<ClientErrors, Client>> create(Client client) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<ClientErrors, Client>> update(Client client) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Either<ClientErrors, bool>> disable(Client client) {
    // TODO: implement disable
    throw UnimplementedError();
  }

  @override
  Future<Either<ClientErrors, List<Client>>> finalAll(Client client) {
    // TODO: implement finalAll
    throw UnimplementedError();
  }
}
