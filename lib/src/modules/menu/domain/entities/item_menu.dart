class ItemMenu {
  String id;
  String name;
  String description;
  String imgUrl;

  List<int> weekdayList;

  ItemMenu(
      {required this.id,
      required this.name,
      required this.description,
      required this.imgUrl,
      required this.weekdayList});
}
