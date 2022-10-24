import 'package:cardapio_manager/src/modules/survey/domain/usecases/i_survey_usecase.dart';
import 'package:cardapio_manager/src/modules/survey/presenter/bloc/events/survey_response_events.dart';
import 'package:cardapio_manager/src/modules/survey/presenter/bloc/states/survey_response_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SurveyResponseBloc
    extends Bloc<SurveyResponseEvents, SurveyResponseStates> {
  final ISurveyUsecase surveyUsecase;

  SurveyResponseBloc(this.surveyUsecase) : super(SurveyResponseIdleState()) {
    on<GetSurveyResponsesBySurveyEvent>((event, emit) async {
      emit(SurveyResponseLoadingState());

      final result =
          await surveyUsecase.getSurveyResponseListBySurvey(event.survey);
      result.fold((l) => emit(SurveyResponseErrorState(l)),
          (r) => emit(GetSurveyResponseListSuccessState(r)));
    });
  }
}
