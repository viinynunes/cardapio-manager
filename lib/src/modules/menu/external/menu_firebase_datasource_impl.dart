import 'package:cardapio_manager/src/modules/menu/infra/datasources/i_item_menu_datasource.dart';
import 'package:cardapio_manager/src/modules/menu/infra/models/item_menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MenuFirebaseDatasourceImpl implements IItemMenuDatasource {
  final _menuCollection = FirebaseFirestore.instance.collection('menu');
  final _menuStorage = FirebaseStorage.instance.ref().child('images');

  @override
  Future<ItemMenuModel> create(ItemMenuModel item) async {
/*    final result = await _menuCollection.add(item.toMap()).then((value) {
      item.id = value.id;
      _menuCollection.doc(item.id).update(item.toMap());
    }).catchError((e) => throw Exception(e.toString()));

    return item;*/
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<ItemMenuModel> update(ItemMenuModel item) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<bool> disable(String id) {
    // TODO: implement disable
    throw UnimplementedError();
  }

  @override
  Future<List<ItemMenuModel>> findAll() async {
    List<ItemMenuModel> menuList = [];

    final result = await _menuCollection.get();

    for (var index in result.docs) {
      menuList.add(ItemMenuModel.fromMap(map: index.data()));
    }

    return menuList;
  }
}
