class ItemMenu {
  String? id;
  String name;
  String description;
  String imgUrl;
  bool enabled;

  List<int> weekdayList;

  ItemMenu(
      {required this.id,
      required this.name,
      required this.description,
      required this.imgUrl,
      required this.enabled,
      required this.weekdayList});
}
