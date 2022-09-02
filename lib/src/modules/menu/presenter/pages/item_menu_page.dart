import 'dart:io';

import 'package:cardapio_manager/src/modules/core/camera/presenter/bloc/states/camera_states.dart';
import 'package:cardapio_manager/src/modules/menu/presenter/bloc/item_menu_bloc.dart';
import 'package:cardapio_manager/src/modules/menu/presenter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/camera/presenter/bloc/camera_bloc.dart';
import '../../../core/camera/presenter/bloc/events/camera_events.dart';
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
  bool itemEnabled = true;

  late File image;

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  late AnimationController cameraSourceAnimatedController;
  late Animation<double> cameraSourceAnimation;

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

    cameraSourceAnimatedController = AnimationController(vsync: this);
    cameraSourceAnimatedController.duration = const Duration(milliseconds: 0);
    cameraSourceAnimation = Tween<double>(begin: 0, end: 100)
        .animate(cameraSourceAnimatedController);

    cameraSourceAnimation.addStatusListener((status) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var cameraSourceContainerColor = Colors.white;

    _getImageContainer(File file) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: FileImage(file),
          ),
        ),
      );
    }

    _getNetWorkImageContainer(String imagePath) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(imagePath)),
        ),
      );
    }

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
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      height: size.height * 0.4,
                      child: Stack(
                        children: [
                          BlocBuilder<CameraBloc, CameraStates>(
                            bloc: cameraBloc,
                            builder: (_, state) {
                              if (state is CameraSuccessState) {
                                image = state.file;
                                return _getImageContainer(image);
                              }

                              return _getNetWorkImageContainer(
                                  URLS.itemMenuNoImageUrl);
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                                padding: const EdgeInsets.only(right: 4),
                                width: size.width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    AnimatedContainer(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Theme.of(context)
                                              .secondaryHeaderColor),
                                      curve: Curves.elasticOut,
                                      width: 50,
                                      height: cameraSourceAnimation.value,
                                      duration: const Duration(seconds: 1),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.black38),
                                        child: Column(
                                          children: [
                                            Flexible(
                                              child: IconButton(
                                                onPressed: () {
                                                  cameraBloc.add(PickImageEvent(
                                                      imageFrom: 'camera'));
                                                },
                                                icon: Icon(
                                                  Icons.camera_alt,
                                                  color:
                                                      cameraSourceContainerColor,
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: IconButton(
                                                onPressed: () {
                                                  cameraBloc.add(PickImageEvent(
                                                      imageFrom: 'gallery'));
                                                },
                                                icon: Icon(
                                                  Icons.file_upload,
                                                  color:
                                                      cameraSourceContainerColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        cameraSourceAnimatedController
                                            .forward();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.8)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          Text('Alterar Foto'),
                                          Icon(Icons.camera_alt_rounded),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
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
