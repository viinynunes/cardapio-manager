import 'package:cardapio_manager/src/modules/menu/domain/entities/item_menu.dart';
import 'package:cardapio_manager/src/modules/menu/presenter/bloc/events/item_menu_events.dart';
import 'package:cardapio_manager/src/modules/menu/presenter/bloc/item_menu_bloc.dart';
import 'package:cardapio_manager/src/modules/menu/presenter/bloc/states/item_menu_states.dart';
import 'package:cardapio_manager/src/modules/menu/presenter/pages/tiles/item_menu_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ItemMenuListPage extends StatefulWidget {
  const ItemMenuListPage({Key? key}) : super(key: key);

  @override
  State<ItemMenuListPage> createState() => _ItemMenuListPageState();
}

class _ItemMenuListPageState extends State<ItemMenuListPage> {
  final bloc = Modular.get<ItemMenuBloc>();

  @override
  void initState() {
    super.initState();

    bloc.add(GetItemMenuListEvent());
  }

  _saveOrUpdate({ItemMenu? item}) async {
    final recItem = await Modular.to.pushNamed('/item/', arguments: [item]);

    if (recItem != null && recItem is ItemMenu) {
      if (item == null) {
        bloc.add(CreateItemMenuEvent(recItem));
      } else {
        bloc.add(UpdateItemMenuEvent(recItem));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardápio'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveOrUpdate();
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: BlocBuilder<ItemMenuBloc, ItemMenuStates>(
          bloc: bloc,
          builder: (_, state) {
            if (state is ItemMenuLoadingState) {
              return Overlay(
                initialEntries: [
                  OverlayEntry(
                    builder: (context) {
                      return Container(
                        color: Colors.black38,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ],
              );
            }

            if (state is ItemMenuErrorState) {
              return Center(
                child: Text(state.error.message),
              );
            }

            if (state is ItemMenuGetListSuccessState) {
              final menuList = state.menuList;

              return ListView.builder(
                itemCount: menuList.length,
                itemBuilder: (_, index) {
                  final item = menuList[index];
                  return ItemMenuListTile(
                    item: item,
                    onTap: () {
                      _saveOrUpdate(item: item);
                    },
                  );
                },
              );
            }

            if (state is ItemMenuCreateOrUpdateSuccessState) {
              bloc.add(GetItemMenuListEvent());
              return Overlay(
                initialEntries: [
                  OverlayEntry(builder: (_) {
                    return Container(
                      color: Colors.white70,
                      child: Column(
                        children: const [
                          Text('Item salvo com sucesso!'),
                        ],
                      ),
                    );
                  })
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
