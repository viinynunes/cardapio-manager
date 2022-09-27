import 'package:cardapio_manager/src/modules/core/client/presenter/bloc/client_bloc.dart';
import 'package:cardapio_manager/src/modules/core/client/presenter/bloc/events/client_events.dart';
import 'package:cardapio_manager/src/modules/core/client/presenter/bloc/states/client_states.dart';
import 'package:cardapio_manager/src/modules/core/client/presenter/pages/tiles/client_list_tile.dart';
import 'package:cardapio_manager/src/modules/core/drawer/presenter/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/client.dart';

class ClientListPage extends StatefulWidget {
  const ClientListPage({Key? key}) : super(key: key);

  @override
  State<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  final clientBloc = Modular.get<ClientBloc>();
  List<Client> clientList = [];
  List<Client> clientFullList = [];

  bool isSearching = false;
  final searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    clientBloc.add(GetClientListEvent());
  }

  _createOrUpdate({Client? client}) async {
    final recClient = await Modular.to
        .pushNamed('./client-registration/', arguments: [client]);

    if (recClient != null && recClient is Client) {
      clientBloc.add(CreateOrUpdateClientEvent(recClient));
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
                decoration: const InputDecoration(hintText: 'Pesquisar'),
                onChanged: (searchText) {
                  if (searchText.isEmpty) {
                    clientBloc.add(GetClientListEvent());
                  }
                  clientBloc.add(
                      FilterClientListByTextEvent(clientFullList, searchText));
                },
              )
            : const Text('Clientes'),
        centerTitle: true,
        actions: [
          isSearching
              ? IconButton(
                  onPressed: () {
                    clientBloc.add(GetClientListEvent());
                    setState(() {
                      isSearching = isSearching = false;
                    });
                  },
                  icon: const Icon(Icons.clear))
              : IconButton(
                  onPressed: () {
                    searchFocus.requestFocus();
                    setState(() {
                      isSearching = true;
                    });
                  },
                  icon: const Icon(Icons.search))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createOrUpdate();
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height,
                width: size.width,
                child: BlocBuilder<ClientBloc, ClientStates>(
                  bloc: clientBloc,
                  builder: (_, state) {
                    if (state is ClientErrorState) {
                      return Center(
                        child: Text(state.error.message),
                      );
                    }

                    if (state is ClientLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is ClientCreateOrUpdateSuccessState) {
                      clientBloc.add(GetClientListEvent());
                    }

                    if (state is ClientGetListSuccessState) {
                      this.clientList = state.clientList;
                      if (clientFullList.isEmpty) {
                        clientFullList = state.clientList;
                      }
                      final clientList = state.clientList;

                      return ListView.builder(
                        itemCount: clientList.length,
                        itemBuilder: (_, index) {
                          final client = clientList[index];
                          return ClientListTile(
                              client: client,
                              onTap: () async =>
                                  _createOrUpdate(client: client));
                        },
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
