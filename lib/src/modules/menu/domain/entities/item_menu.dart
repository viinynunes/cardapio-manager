import 'dart:io';

class ItemMenu {
  String? id;
  String name;
  String description;
  String imgUrl;
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
