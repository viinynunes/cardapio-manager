import '../../../domain/entities/item_menu.dart';

abstract class ItemMenuEvents {}

class CreateItemMenuEvent implements ItemMenuEvents {
  ItemMenu itemMenu;

  CreateItemMenuEvent(this.itemMenu);
}

class UpdateItemMenuEvent implements ItemMenuEvents {
  ItemMenu itemMenu;

  UpdateItemMenuEvent(this.itemMenu);
}

class DisableItemMenuEvent implements ItemMenuEvents {
  String id;

  DisableItemMenuEvent(this.id);
}

class GetItemMenuListEvent implements ItemMenuEvents {}
