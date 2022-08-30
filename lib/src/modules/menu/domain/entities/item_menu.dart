import 'dart:io';

class ItemMenu {
  String? id;
  String name;
  String description;
  String imgUrl =
      'https://firebasestorage.googleapis.com/v0/b/cardapio-app-39905.appspot.com/o/images%2Fmenu-no-picture.jpg?alt=media&token=9f3b9daf-c3e7-4c00-bb16-e8851b5699f7';
  bool enabled;

  List<int> weekdayList;
  File? imgFile;

  ItemMenu({
    required this.id,
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.enabled,
    required this.weekdayList,
    this.imgFile,
  });
}
