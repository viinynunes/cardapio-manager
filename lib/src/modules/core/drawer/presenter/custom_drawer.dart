import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/events/logged_user_events.dart';
import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/events/login_events.dart';
import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/logged_user_bloc.dart';
import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/login_bloc.dart';
import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/states/logged_user_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final loggedUserBloc = Modular.get<LoggedUserBloc>();
  final loginBloc = Modular.get<LoginBloc>();

  @override
  void initState() {
    super.initState();

    loggedUserBloc.add(GetLoggedUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Stack(
              children: [
                BlocBuilder<LoggedUserBloc, LoggedUserStates>(
                  bloc: loggedUserBloc,
                  builder: (_, state) {
                    if (state is LoggedUserLoginSuccessState) {
                      return UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.8),
                        ),
                        accountName: Text(state.user.name),
                        accountEmail: Text(state.user.email),
                        currentAccountPicture: CircleAvatar(
                          backgroundColor: Theme.of(context).hintColor,
                          child: const Icon(Icons.account_circle),
                        ),
                      );
                    }

                    if (state is LoggedUserErrorState) {
                      return Center(
                        child: Text(
                            'Erro ao realizar o login: ${state.error.message}'),
                      );
                    }

                    return Container();
                  },
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    onPressed: () {
                      loginBloc.add(LogoutEvent());

                      Modular.to.pushReplacementNamed('/auth/');
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              onTap: () {
                Modular.to.pop();
                Modular.to.navigate('/home/');
              },
              leading: const Icon(Icons.home),
              title: const Center(child: Text('Home')),
            ),
            ListTile(
              onTap: () {
                Modular.to.pop();
                Modular.to.navigate('/order/');
              },
              leading: const Icon(Icons.reorder),
              title: const Center(child: Text('Pedidos')),
            ),
            ListTile(
              onTap: () {
                Modular.to.pop();
                Modular.to.navigate('/menu/');
              },
              leading: const Icon(Icons.menu_book),
              title: const Center(child: Text('Menu')),
            ),
            ListTile(
              onTap: () {
                Modular.to.pop();
                Modular.to.navigate('/client/');
              },
              leading: const Icon(Icons.account_circle),
              title: const Center(child: Text('Clientes')),
            ),
          ],
        ),
      ),
    );
  }
}
