import 'package:cardapio_manager/src/modules/menu/domain/entities/item_menu.dart';
import 'package:cardapio_manager/src/modules/menu/domain/repositories/i_item_menu_repository.dart';
import 'package:cardapio_manager/src/modules/menu/domain/usecases/i_item_menu_usecase.dart';
import 'package:cardapio_manager/src/modules/menu/errors/item_menu_errors.dart';
import 'package:dartz/dartz.dart';

class ItemMenuUsecaseImpl implements IItemMenuUsecase {
  final IItemMenuRepository _repository;

  ItemMenuUsecaseImpl(this._repository);

  @override
  Future<Either<ItemMenuError, ItemMenu>> create(ItemMenu item) async {
    if (item.name.length < 2) {
      return Left(ItemMenuError('Enter a valid name'));
    }

    if (item.weekdayList.isEmpty) {
      return Left(ItemMenuError('Invalid weekday list'));
    }

    return _repository.create(item);
  }

  @override
  Future<Either<ItemMenuError, ItemMenu>> update(ItemMenu item) async {
    if (item.id == null || item.id!.isEmpty) {
      return Left(ItemMenuError('item menu id is invalid'));
    }
    if (item.name.length < 2) {
      return Left(ItemMenuError('Enter a valid name'));
    }

    if (item.weekdayList.isEmpty) {
      return Left(ItemMenuError('Invalid weekday list'));
    }

    return _repository.update(item);
  }

  @override
  Future<Either<ItemMenuError, bool>> disable(String id) async {
    if (id.isEmpty) {
      return Left(ItemMenuError('Invalid id'));
    }

    return _repository.disable(id);
  }

  @override
  Future<Either<ItemMenuError, List<ItemMenu>>> findAll() async {
    return _repository.findAll();
  }

  @override
  Future<Either<ItemMenuError, List<ItemMenu>>> findAllDisabled() async {
    return _repository.findAllDisabled();
  }

  @override
  Future<Either<ItemMenuError, List<ItemMenu>>> findAllEnabled() async {
    return _repository.findAllEnabled();
  }
}
