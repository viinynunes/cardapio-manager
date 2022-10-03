import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/events/logged_user_events.dart';
import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/states/logged_user_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/auth/presenter/bloc/logged_user_bloc.dart';

class InitialSplash extends StatefulWidget {
  const InitialSplash({Key? key}) : super(key: key);

  @override
  State<InitialSplash> createState() => _InitialSplashState();
}

class _InitialSplashState extends State<InitialSplash> {
  final loggedUserBloc = Modular.get<LoggedUserBloc>();

  @override
  void initState() {
    super.initState();

    loggedUserBloc.add(GetLoggedUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            height: 2,
            width: 2,
            child: BlocBuilder<LoggedUserBloc, LoggedUserStates>(
              bloc: loggedUserBloc,
              builder: (_, state) {
                if (state is LoggedUserLoginSuccessState) {
                  Modular.to.pushReplacementNamed('/home/');
                }

                if (state is LoggedUserErrorState) {
                  Modular.to.pushReplacementNamed('/auth/');
                }

                return Container();
              },
            ),
          )
        ],
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
