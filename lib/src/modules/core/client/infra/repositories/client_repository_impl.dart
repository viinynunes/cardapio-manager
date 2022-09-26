import 'package:cardapio_manager/src/modules/core/client/domain/entities/client.dart';
import 'package:cardapio_manager/src/modules/core/client/domain/repositories/client_repository.dart';
import 'package:cardapio_manager/src/modules/core/client/errors/client_errors.dart';
import 'package:cardapio_manager/src/modules/core/client/infra/datasources/client_datasource.dart';
import 'package:cardapio_manager/src/modules/core/client/infra/models/client_model.dart';
import 'package:dartz/dartz.dart';

class ClientRepositoryImpl implements IClientRepository {
  final IClientDatasource _datasource;

  ClientRepositoryImpl(this._datasource);

  @override
  Future<Either<ClientErrors, Client>> create(Client client) async {
    try {
      final result = await _datasource.create(ClientModel.fromClient(client));

      return Right(result);
    } catch (e) {
      return Left(ClientErrors(e.toString()));
    }
  }

  @override
  Future<Either<ClientErrors, Client>> update(Client client) async {
    try {
      final result = await _datasource.update(ClientModel.fromClient(client));

      return Right(result);
    } catch (e) {
      return Left(ClientErrors(e.toString()));
    }
  }

  @override
  Future<Either<ClientErrors, bool>> disable(Client client) async {
    try {
      final result = await _datasource.disable(ClientModel.fromClient(client));

      return Right(result);
    } catch (e) {
      return Left(ClientErrors(e.toString()));
    }
  }

  @override
  Future<Either<ClientErrors, List<Client>>> findAll() async {
    try {
      final result = await _datasource.findAll();

      return Right(result);
    } catch (e) {
      return Left(ClientErrors(e.toString()));
    }
  }
}
