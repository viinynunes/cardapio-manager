import 'package:cardapio_manager/src/modules/menu/domain/entities/item_menu.dart';

class ItemMenuModel extends ItemMenu {
  ItemMenuModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.imgUrl,
      required super.enabled,
      required super.weekdayList,
      super.imgFile});

  ItemMenuModel.fromItemMenu({required ItemMenu item})
      : super(
          id: item.id,
          name: item.name,
          description: item.description,
          imgUrl: item.imgUrl,
          enabled: item.enabled,
          weekdayList: item.weekdayList,
          imgFile: item.imgFile,
        );

  ItemMenuModel.fromMap({required Map<String, dynamic> map})
      : super(
            id: map['id'],
            name: map['name'],
            description: map['description'],
            imgUrl: map['imgUrl'],
            enabled: map['enabled'],
            weekdayList: map['weekdayList'].cast<int>());

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imgUrl': imgUrl,
      'enabled': enabled,
      'weekdayList': weekdayList,
    };
  }
}
