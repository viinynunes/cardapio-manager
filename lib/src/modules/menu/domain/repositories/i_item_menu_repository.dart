import 'package:cardapio_manager/src/modules/menu/errors/item_menu_errors.dart';
import 'package:dartz/dartz.dart';

import '../entities/item_menu.dart';

abstract class IItemMenuRepository {
  Future<Either<ItemMenuError, ItemMenu>> create(ItemMenu item);

  Future<Either<ItemMenuError, ItemMenu>> update(ItemMenu item);

  Future<Either<ItemMenuError, bool>> disable(String id);

  Future<Either<ItemMenuError, List<ItemMenu>>> findAll();
}
