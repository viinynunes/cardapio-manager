import 'package:cardapio_manager/src/modules/core/weekday/domain/entities/weekday.dart';
import 'package:cardapio_manager/src/modules/menu/domain/entities/item_menu.dart';
import 'package:cardapio_manager/src/modules/menu/domain/repositories/i_item_menu_repository.dart';
import 'package:cardapio_manager/src/modules/menu/errors/item_menu_errors.dart';
import 'package:cardapio_manager/src/modules/menu/infra/datasources/i_item_menu_datasource.dart';
import 'package:cardapio_manager/src/modules/menu/infra/models/item_menu_model.dart';
import 'package:dartz/dartz.dart';

class ItemMenuRepositoryImpl implements IItemMenuRepository {
  final IItemMenuDatasource _datasource;

  ItemMenuRepositoryImpl(this._datasource);

  @override
  Future<Either<ItemMenuError, ItemMenu>> create(ItemMenu item) async {
    try {
      final result =
          await _datasource.create(ItemMenuModel.fromItemMenu(item: item));

      return Right(result);
    } catch (e) {
      return Left(ItemMenuError(e.toString()));
    }
  }

  @override
  Future<Either<ItemMenuError, ItemMenu>> update(ItemMenu item) async {
    try {
      final result =
          await _datasource.update(ItemMenuModel.fromItemMenu(item: item));

      return Right(result);
    } catch (e) {
      return Left(ItemMenuError(e.toString()));
    }
  }

  @override
  Future<Either<ItemMenuError, bool>> disable(String id) async {
    try {
      final result = await _datasource.disable(id);

      return Right(result);
    } catch (e) {
      return Left(ItemMenuError(e.toString()));
    }
  }

  @override
  Future<Either<ItemMenuError, List<ItemMenu>>> findByWeekday(Weekday weekday) async {
    try {
      final result = await _datasource.findByWeekday(weekday);

      return Right(result);
    } catch (e) {
      return Left(ItemMenuError(e.toString()));
    }
  }

  @override
  Future<Either<ItemMenuError, List<ItemMenu>>> findAllDisabledByWeekday(Weekday weekday) async {
    try {
      final result = await _datasource.findAllDisabledByWeekday(weekday);

      return Right(result);
    } catch (e) {
      return Left(ItemMenuError(e.toString()));
    }
  }

  @override
  Future<Either<ItemMenuError, List<ItemMenu>>> findAllEnabledByWeekday(Weekday weekday) async {
    try {
      final result = await _datasource.findAllEnabledByWeekday(weekday);

      return Right(result);
    } catch (e) {
      return Left(ItemMenuError(e.toString()));
    }
  }
}
