import 'package:cardapio_manager/src/modules/menu/domain/entities/item_menu.dart';
import 'package:cardapio_manager/src/modules/menu/services/i_item_menu_services.dart';

class ItemMenuServicesImpl implements IItemMenuService {
  @override
  List<ItemMenu> searchFilter(List<ItemMenu> itemList, String searchText) {
    if (searchText.isEmpty) {
      return itemList;
    }

    List<ItemMenu> filteredList = [];

    for (var e in itemList) {
      if (e.name.toUpperCase().contains(searchText.toUpperCase())) {
        filteredList.add(e);
      }
    }

    return filteredList;
  }
}
