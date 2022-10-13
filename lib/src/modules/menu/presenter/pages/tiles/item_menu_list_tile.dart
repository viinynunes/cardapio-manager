import 'package:cardapio_manager/src/modules/menu/domain/entities/item_menu.dart';
import 'package:flutter/material.dart';

class ItemMenuListTile extends StatelessWidget {
  const ItemMenuListTile({Key? key, required this.item, required this.onTap})
      : super(key: key);

  final ItemMenu item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(8),
          height: size.height * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).primaryColor.withOpacity(0.05),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: NetworkImage(item.imgUrl), fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(
                  children: [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text(item.name),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text(
                        item.description,
                        maxLines: 2,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            item.enabled ? 'ativado' : 'desativado',
                            style: TextStyle(
                                fontSize: 12,
                                color:
                                    item.enabled ? Colors.green : Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
