import 'package:cardapio_manager/src/modules/menu/domain/entities/item_menu.dart';

abstract class IItemMenuService {
  List<ItemMenu> searchFilter(List<ItemMenu> itemList, String searchText);
}
