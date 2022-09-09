import 'package:cardapio_manager/src/modules/menu/infra/models/item_menu_model.dart';

abstract class IItemMenuDatasource {
  Future<ItemMenuModel> create(ItemMenuModel item);

  Future<ItemMenuModel> update(ItemMenuModel item);

  Future<bool> disable(String id);

  Future<List<ItemMenuModel>> findAll();

  Future<List<ItemMenuModel>> findAllEnabled();

  Future<List<ItemMenuModel>> findAllDisabled();
}
