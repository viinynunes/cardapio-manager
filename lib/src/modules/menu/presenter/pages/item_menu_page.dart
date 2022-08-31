import 'package:cardapio_manager/src/modules/menu/presenter/bloc/item_menu_bloc.dart';
import 'package:cardapio_manager/src/modules/menu/presenter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/item_menu.dart';
import '../../infra/models/item_menu_model.dart';

class ItemMenuPage extends StatefulWidget {
  const ItemMenuPage({Key? key, this.itemMenu}) : super(key: key);

  final ItemMenu? itemMenu;

  @override
  State<ItemMenuPage> createState() => _ItemMenuPageState();
}

class _ItemMenuPageState extends State<ItemMenuPage> {
  final bloc = Modular.get<ItemMenuBloc>();

  late ItemMenuModel modelFromItemMenu;
  late ItemMenuModel newItemMenu;
  late bool newItem;
  bool itemEnabled = true;

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.itemMenu != null) {
      newItem = false;
      modelFromItemMenu = ItemMenuModel.fromItemMenu(item: widget.itemMenu!);
      newItemMenu = ItemMenuModel.fromMap(map: modelFromItemMenu.toMap());

      nameController.text = newItemMenu.name;
      descriptionController.text = newItemMenu.description;
      itemEnabled = newItemMenu.enabled;
    } else {
      newItem = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(newItem ? 'Novo Item' : 'Editar Item'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    height: size.height * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(newItem
                            ? URLS.itemMenuNoImageUrl
                            : newItemMenu.imgUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: size.width * 0.4,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text('Alterar Foto'),
                              Icon(Icons.camera_alt_rounded),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: 'Nome',
                      hintText: 'Nome',
                    ),
                    validator: (text) {
                      if (text!.length < 2) {
                        return 'Nome Inválido';
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    height: size.height * 0.15,
                    child: TextFormField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: 'Descrição',
                        hintText: 'Descrição',
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text('Ativo'),
                      Switch(
                        value: itemEnabled,
                        onChanged: (e) {
                          setState(() => itemEnabled = e);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
