import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/i_survey_usecase.dart';
import 'events/survey_events.dart';
import 'states/survey_states.dart';

class SurveyBloc extends Bloc<SurveyEvents, SurveyStates> {
  final ISurveyUsecase surveyUsecase;

  SurveyBloc(this.surveyUsecase) : super(SurveyIdleState()) {
    on<GetSurveyListEvent>((event, emit) async {
      emit(SurveyLoadingState());

      final result = await surveyUsecase.getSurveyList();

      result.fold((l) => emit(SurveyErrorState(l)),
          (r) => emit(GetSurveyListSuccessState(r)));
    });

    on<CreateSurveyEvent>((event, emit) async {
      emit(SurveyLoadingState());

      final result = await surveyUsecase.createSurvey(event.survey);

      result.fold(
          (l) => emit(SurveyErrorState(l)), (r) => SurveySuccessState(r));
    });

    on<UpdateSurveyEvent>((event, emit) async {
      emit(SurveyLoadingState());

      final result = await surveyUsecase.updateSurvey(event.survey);

      result.fold(
          (l) => emit(SurveyErrorState(l)), (r) => SurveySuccessState(r));
    });
  }
}
