import 'package:cardapio_manager/src/modules/core/auth/domain/usecases/i_login_usecase.dart';
import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/events/logged_user_events.dart';
import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/events/login_events.dart';
import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/states/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logged_user_bloc.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final ILoginUsecase loginUsecase;
  final LoggedUserBloc loggedUserBloc;

  LoginBloc(this.loginUsecase, this.loggedUserBloc) : super(LoginIdleState()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoadingState());

      final result = await loginUsecase.login(event.email, event.password);

      result.fold((l) => emit(LoginErrorState(l)), (user) async {
        loggedUserBloc.add(SaveLoggedUserEvent(user));
      });
    });
  }
}
