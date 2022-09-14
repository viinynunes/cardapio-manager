import 'package:flutter/material.dart';

import '../../../../menu/domain/entities/item_menu.dart';

class OrderItemMenuTile extends StatelessWidget {
  const OrderItemMenuTile({Key? key, required this.itemMenu}) : super(key: key);

  final ItemMenu itemMenu;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[300],
      ),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              height: size.height * 0.12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(itemMenu.imgUrl),
                  fit: BoxFit.cover,
                  colorFilter:
                      const ColorFilter.mode(Colors.black26, BlendMode.darken),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemMenu.name,
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  itemMenu.description,
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
