import 'package:cardapio_manager/src/modules/core/client/domain/entities/client.dart';
import 'package:flutter/material.dart';

class ClientListTile extends StatelessWidget {
  const ClientListTile({Key? key, required this.client, required this.onTap})
      : super(key: key);

  final Client client;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.1,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Text(client.name),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Text(client.email),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(client.phone),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
