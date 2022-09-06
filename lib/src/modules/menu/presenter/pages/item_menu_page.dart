import 'dart:io';

import 'package:cardapio_manager/src/modules/menu/presenter/bloc/days_of_week_bloc.dart';
import 'package:cardapio_manager/src/modules/menu/presenter/bloc/states/days_of_week_state.dart';
import 'package:cardapio_manager/src/modules/menu/presenter/pages/tiles/weekday_list_tile.dart';
import 'package:cardapio_manager/src/modules/menu/presenter/pages/widgets/item_menu_principal_image_container.dart';
import 'package:cardapio_manager/src/modules/menu/presenter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/item_menu.dart';
import '../../infra/models/item_menu_model.dart';
import '../bloc/events/days_of_week_event.dart';

class ItemMenuPage extends StatefulWidget {
  const ItemMenuPage({Key? key, this.itemMenu}) : super(key: key);

  final ItemMenu? itemMenu;

  @override
  State<ItemMenuPage> createState() => _ItemMenuPageState();
}

class _ItemMenuPageState extends State<ItemMenuPage>
    with SingleTickerProviderStateMixin {
  final daysOfWeekBloc = Modular.get<DaysOfWeekBloc>();

  late ItemMenuModel modelFromItemMenu;
  late ItemMenuModel newItemMenu;
  late bool newItem;
  File? image;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  bool itemEnabled = true;

  List<int> weekdayList = [];

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    daysOfWeekBloc.add(GetOrderedWeekdaysOrderedByToday(DateTime.now()));

    if (widget.itemMenu != null) {
      newItem = false;
      modelFromItemMenu = ItemMenuModel.fromItemMenu(item: widget.itemMenu!);
      newItemMenu = ItemMenuModel.fromMap(map: modelFromItemMenu.toMap());

      nameController.text = newItemMenu.name;
      descriptionController.text = newItemMenu.description;
      itemEnabled = newItemMenu.enabled;
      weekdayList = newItemMenu.weekdayList;
    } else {
      newItem = true;
    }
  }

  _saveItem() {
    newItemMenu = ItemMenuModel(
        id: newItem ? null : newItemMenu.id,
        name: nameController.text,
        description: descriptionController.text,
        imgUrl: newItem ? URLS.itemMenuNoImageUrl : newItemMenu.imgUrl,
        enabled: itemEnabled,
        weekdayList: weekdayList,
        imgFile: image);
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
        onPressed: () {
          if (formKey.currentState!.validate()) {
            _saveItem();
            Modular.to.pop(newItemMenu);
          }
        },
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
                  ItemMenuPrincipalImageContainer(
                    getFileImage: (File? fileImage) {
                      if (fileImage != null) {
                        image = fileImage;
                      }
                    },
                    imgUrl:
                        newItem ? URLS.itemMenuNoImageUrl : newItemMenu.imgUrl,
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
                    width: size.width,
                    height: size.height * 0.12,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey)),
                    child: BlocBuilder<DaysOfWeekBloc, DaysOfWeekState>(
                      bloc: daysOfWeekBloc,
                      builder: (_, state) {
                        if (state is DaysOfWeekSuccessState) {
                          final daysList = state.weekDayList;

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: daysList.length,
                            itemBuilder: (_, index) {
                              final weekday = daysList[index];
                              return WeekdayListTile(
                                  weekday: weekday,
                                  checked:
                                      weekdayList.contains(weekday.weekday),
                                  onAdd: (e) {
                                    setState(() => weekdayList.add(e));
                                  },
                                  onRemove: (e) {
                                    setState(() => weekdayList.removeWhere(
                                        (element) => e == element));
                                  });
                            },
                          );
                        }

                        return Container();
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    height: size.height * 0.075,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
