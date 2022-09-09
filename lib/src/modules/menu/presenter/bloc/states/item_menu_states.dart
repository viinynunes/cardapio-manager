import 'package:cardapio_manager/src/modules/menu/errors/item_menu_errors.dart';

import '../../../domain/entities/item_menu.dart';

abstract class ItemMenuStates {}

class ItemMenuIdleState implements ItemMenuStates {}

class ItemMenuLoadingState implements ItemMenuStates {}

class ItemMenuSuccessState implements ItemMenuStates {}

class ItemMenuGetListSuccessState implements ItemMenuStates {
  final List<ItemMenu> menuList;

  ItemMenuGetListSuccessState(this.menuList);
}

class ItemMenuGetFilteredListSuccessState implements ItemMenuStates {
  final List<ItemMenu> menuList;

  ItemMenuGetFilteredListSuccessState(this.menuList);
}

class ItemMenuCreateOrUpdateSuccessState implements ItemMenuStates {
  final ItemMenu item;

  ItemMenuCreateOrUpdateSuccessState(this.item);
}

class ItemMenuErrorState implements ItemMenuStates {
  final ItemMenuError error;

  ItemMenuErrorState(this.error);
}
