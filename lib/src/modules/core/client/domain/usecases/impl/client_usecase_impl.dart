import 'package:cardapio_manager/src/modules/core/client/domain/entities/client.dart';
import 'package:cardapio_manager/src/modules/core/client/domain/repositories/client_repository.dart';
import 'package:cardapio_manager/src/modules/core/client/domain/usecases/i_client_usecase.dart';
import 'package:cardapio_manager/src/modules/core/client/errors/client_errors.dart';
import 'package:dartz/dartz.dart';

class ClientUsecaseImpl implements IClientUsecase {
  final IClientRepository _repository;

  ClientUsecaseImpl(this._repository);

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
