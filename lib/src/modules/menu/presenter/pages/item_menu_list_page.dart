import 'package:cardapio_manager/src/modules/core/drawer/presenter/custom_drawer.dart';
import 'package:cardapio_manager/src/modules/core/weekday/domain/entities/weekday.dart';
import 'package:cardapio_manager/src/modules/core/weekday/presenter/bloc/days_of_week_bloc.dart';
import 'package:cardapio_manager/src/modules/core/weekday/presenter/pages/weekday_scroll_horizontal_list_widget.dart';
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
  final itemBloc = Modular.get<ItemMenuBloc>();
  final daysBloc = Modular.get<DaysOfWeekBloc>();

  List<ItemMenu> itemMenuList = [];

  late Weekday weekday;

  bool isSearching = false;
  String searchText = '';
  final searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    weekday = Weekday(DateTime.now().weekday, 'name', true);
    itemBloc.add(GetItemMenuListEvent(weekday));
  }

  _saveOrUpdate({ItemMenu? item}) async {
    final recItem = await Modular.to.pushNamed('/item/', arguments: [item, weekday]);
    if (recItem != null && recItem is ItemMenu) {
      if (item == null) {
        itemBloc.add(CreateItemMenuEvent(recItem));
      } else {
        itemBloc.add(UpdateItemMenuEvent(recItem));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: isSearching
            ? TextField(
                focusNode: searchFocus,
                decoration: const InputDecoration(
                  hintText: ' Pesquisar',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (text) {
                  itemBloc.add(FilterItemMenuListEvent(
                      searchText: text, menuList: itemMenuList));
                },
              )
            : const Text('Cardápio'),
        centerTitle: true,
        actions: [
          isSearching
              ? IconButton(
                  onPressed: () {
                    itemBloc.add(GetItemMenuListEvent(weekday));
                    searchText = '';
                    setState(() => isSearching = !isSearching);
                  },
                  icon: const Icon(Icons.cancel))
              : IconButton(
                  onPressed: () {
                    searchFocus.requestFocus();
                    setState(() => isSearching = !isSearching);
                  },
                  icon: const Icon(Icons.search)),
          PopupMenuButton(
            icon: const Icon(Icons.filter_list),
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  onTap: () => itemBloc.add(GetItemMenuListEvent(weekday)),
                  child: const Text('Todos'),
                ),
                PopupMenuItem(
                  onTap: () => itemBloc.add(GetItemMenuListByStatusEvent(
                      enabled: true, weekday: weekday)),
                  child: const Text('Ativado'),
                ),
                PopupMenuItem(
                  onTap: () => itemBloc.add(GetItemMenuListByStatusEvent(
                      enabled: false, weekday: weekday)),
                  child: const Text('Desativado'),
                ),
              ];
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveOrUpdate();
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              WeekdayScrollHorizontalListWidget(
                selectedWeekday: weekday,
                getWeekday: (Weekday recWeekday) {
                  weekday = recWeekday;
                  itemBloc.add(GetItemMenuListEvent(recWeekday));
                },
              ),
              SizedBox(
                height: size.height * 0.9,
                width: size.width,
                child: BlocBuilder<ItemMenuBloc, ItemMenuStates>(
                  bloc: itemBloc,
                  builder: (_, state) {
                    if (state is ItemMenuLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is ItemMenuErrorState) {
                      return Center(
                        child: Text(state.error.message),
                      );
                    }

                    if (state is ItemMenuGetListSuccessState) {
                      itemMenuList = state.menuList;

                      return itemMenuList.isNotEmpty
                          ? ListView.builder(
                              itemCount: itemMenuList.length,
                              itemBuilder: (_, index) {
                                final item = itemMenuList[index];
                                return ItemMenuListTile(
                                  item: item,
                                  onTap: () {
                                    _saveOrUpdate(item: item);
                                  },
                                );
                              },
                            )
                          : const Center(
                              child: Text('Nenhum item encontrado'),
                            );
                    }

                    if (state is ItemMenuGetFilteredListSuccessState) {
                      final filteredList = state.menuList;

                      return filteredList.isNotEmpty
                          ? ListView.builder(
                              itemCount: filteredList.length,
                              itemBuilder: (_, index) {
                                final item = filteredList[index];
                                return ItemMenuListTile(
                                  item: item,
                                  onTap: () {
                                    _saveOrUpdate(item: item);
                                  },
                                );
                              },
                            )
                          : const Center(
                              child: Text('Nenhum item encontrado'),
                            );
                    }

                    if (state is ItemMenuCreateOrUpdateSuccessState) {
                      itemBloc.add(GetItemMenuListEvent(weekday));
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
