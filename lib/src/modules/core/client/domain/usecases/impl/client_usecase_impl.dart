import 'package:cardapio_manager/src/modules/core/client/domain/entities/client.dart';
import 'package:cardapio_manager/src/modules/core/client/domain/repositories/client_repository.dart';
import 'package:cardapio_manager/src/modules/core/client/domain/usecases/i_client_usecase.dart';
import 'package:cardapio_manager/src/modules/core/client/errors/client_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:string_validator/string_validator.dart';

class ClientUsecaseImpl implements IClientUsecase {
  final IClientRepository _repository;

  ClientUsecaseImpl(this._repository);

  @override
  Future<Either<ClientErrors, Client>> create(Client client) async {
    if (client.name.isEmpty || client.name.length < 2) {
      return Left(ClientErrors('Invalid name'));
    }

    if (!isEmail(client.email)) {
      return Left(ClientErrors('Invalid email'));
    }

    if (client.phone.length != 11) {
      return Left(ClientErrors('Invalid phone'));
    }

    return _repository.create(client);
  }

  @override
  Future<Either<ClientErrors, Client>> update(Client client) async {
    if (client.id.isEmpty) {
      return Left(ClientErrors('Invalid ID'));
    }

    if (client.name.isEmpty || client.name.length < 2) {
      return Left(ClientErrors('Invalid name'));
    }

    if (!isEmail(client.email)) {
      return Left(ClientErrors('Invalid email'));
    }

    if (client.phone.length != 11) {
      return Left(ClientErrors('Invalid phone'));
    }

    return _repository.update(client);
  }

  @override
  Future<Either<ClientErrors, bool>> disable(Client client) async {
    if (client.id.isEmpty) {
      return Left(ClientErrors('Invalid ID'));
    }

    return _repository.disable(client);
  }

  @override
  Future<Either<ClientErrors, List<Client>>> findAll() async {
    return _repository.findAll();
  }
}
