import 'package:cardapio_manager/src/modules/menu/errors/item_menu_errors.dart';
import 'package:cardapio_manager/src/modules/menu/infra/datasources/i_item_menu_datasource.dart';
import 'package:cardapio_manager/src/modules/menu/infra/models/item_menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MenuFirebaseDatasourceImpl implements IItemMenuDatasource {
  final _menuCollection = FirebaseFirestore.instance.collection('menu');
  final _menuStorage = FirebaseStorage.instance.ref();

  @override
  Future<ItemMenuModel> create(ItemMenuModel item) async {
    try {
      final recMenu = await _menuCollection
          .add(item.toMap())
          .catchError((e) => throw Exception(e.toString()));

      item.id = recMenu.id;
      if (item.imgFile != null) {
        item.imgUrl = await _uploadFile(item);
      }

      await _menuCollection.doc(item.id).update(item.toMap());
    } on FirebaseException catch (e) {
      throw ItemMenuError(e.message.toString());
    }

    return item;
  }

  @override
  Future<ItemMenuModel> update(ItemMenuModel item) async {
    if (item.imgFile != null) {
      final ref = _menuStorage.child('images/menu/${item.id}');

      await ref.delete();
      item.imgUrl = await _uploadFile(item);
    }

    await _menuCollection
        .doc(item.id)
        .update(item.toMap())
        .catchError((e) => throw Exception(e.toString()));

    return item;
  }

  @override
  Future<bool> disable(String id) async {
    final rec = await _menuCollection.where('id', isEqualTo: id).get();

    final disabledModel = ItemMenuModel.fromMap(map: rec.docs.first.data());

    disabledModel.enabled = false;

    _menuCollection
        .doc(disabledModel.id)
        .update(disabledModel.toMap())
        .catchError((e) => throw Exception(e.toString()));

    return true;
  }

  @override
  Future<List<ItemMenuModel>> findAll() async {
    List<ItemMenuModel> menuList = [];

    final result = await _menuCollection.orderBy('name').get();

    for (var index in result.docs) {
      menuList.add(ItemMenuModel.fromMap(map: index.data()));
    }

    return menuList;
  }

  @override
  Future<List<ItemMenuModel>> findAllDisabled() async {
    List<ItemMenuModel> menuList = [];

    final snap = await _menuCollection
        .where('enabled', isEqualTo: false)
        .orderBy('name')
        .get();

    for (var e in snap.docs) {
      menuList.add(ItemMenuModel.fromMap(map: e.data()));
    }

    return menuList;
  }

  @override
  Future<List<ItemMenuModel>> findAllEnabled() async {
    List<ItemMenuModel> menuList = [];

    final snap = await _menuCollection
        .where('enabled', isEqualTo: true)
        .orderBy('name')
        .get();

    for (var e in snap.docs) {
      menuList.add(ItemMenuModel.fromMap(map: e.data()));
    }

    return menuList;
  }

  Future<String> _uploadFile(ItemMenuModel item) async {
    try {
      final recTask = await _menuStorage
          .child('images/menu/${item.id}')
          .putFile(item.imgFile!);

      return recTask.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw ItemMenuError(e.message.toString());
    }
  }
}
