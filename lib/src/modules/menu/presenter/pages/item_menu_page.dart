import 'package:cardapio_manager/src/modules/menu/presenter/bloc/item_menu_bloc.dart';
import 'package:cardapio_manager/src/modules/menu/presenter/pages/widgets/item_menu_principal_image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/camera/presenter/bloc/camera_bloc.dart';
import '../../domain/entities/item_menu.dart';
import '../../infra/models/item_menu_model.dart';

class ItemMenuPage extends StatefulWidget {
  const ItemMenuPage({Key? key, this.itemMenu}) : super(key: key);

  final ItemMenu? itemMenu;

  @override
  State<ItemMenuPage> createState() => _ItemMenuPageState();
}

class _ItemMenuPageState extends State<ItemMenuPage>
    with SingleTickerProviderStateMixin {
  final itemMenuBloc = Modular.get<ItemMenuBloc>();
  final cameraBloc = Modular.get<CameraBloc>();

  late ItemMenuModel modelFromItemMenu;
  late ItemMenuModel newItemMenu;
  late bool newItem;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  bool itemEnabled = true;

  final formKey = GlobalKey<FormState>();

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemMenuBloc>(create: (_) => itemMenuBloc),
        BlocProvider<CameraBloc>(create: (_) => cameraBloc),
      ],
      child: Scaffold(
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
                    const ItemMenuPrincipalImageContainer(),
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
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        children: [
                          const Text('Ativo'),
                          Switch(
                            value: itemEnabled,
                            onChanged: (e) {
                              setState(() => itemEnabled = e);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
