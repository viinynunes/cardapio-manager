import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/i_days_of_week_usecase.dart';
import 'events/days_of_week_event.dart';
import 'states/days_of_week_state.dart';

class DaysOfWeekBloc extends Bloc<DaysOfWeekEvent, DaysOfWeekState> {
  final IDaysOfWeekUsecase usecase;

  DaysOfWeekBloc(this.usecase) : super(DaysOfWeekInitialState()) {
    on<GetOrderedWeekdaysOrderedByToday>((event, emit) async {
      emit(DaysOfWeekLoadingState());

      final result = usecase(event.today);

      result.fold((l) => emit(DaysOfWeekErrorState(l)),
          (r) => emit(DaysOfWeekSuccessState(r)));
    });
  }
}
