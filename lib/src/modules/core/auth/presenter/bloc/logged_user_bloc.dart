import 'package:cardapio_manager/src/modules/core/auth/domain/usecases/i_logged_user_usecase.dart';
import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/events/logged_user_events.dart';
import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/states/logged_user_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoggedUserBloc extends Bloc<LoggedUserEvents, LoggedUserStates> {
  final ILoggedUserUsecase usecase;

  LoggedUserBloc(this.usecase) : super(LoggedUserIdleState()) {
    on<GetLoggedUserEvent>((event, emit) async {
      emit(LoggedUserLoadingState());

      final result = await usecase.getLoggedUser();

      result.fold((l) => emit(LoggedUserErrorState(l)),
          (r) => emit(LoggedUserSuccessState(r)));
    });

    on<SaveLoggedUserEvent>((event, emit) async {
      emit(LoggedUserLoadingState());

      final loggedResult = await usecase.saveLoggedUser(event.user);

      loggedResult.fold((l) => emit(LoggedUserErrorState(l)),
          (r) => emit(LoggedUserSuccessState(r)));
    });
  }
}
