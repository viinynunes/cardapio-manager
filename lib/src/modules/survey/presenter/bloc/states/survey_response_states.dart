import 'package:cardapio_manager/src/modules/survey/domain/entities/survey_response.dart';

import '../../../domain/entities/survey.dart';
import '../../../errors/survey_errors.dart';

abstract class SurveyResponseStates {}

class SurveyResponseIdleState implements SurveyResponseStates {}

class SurveyResponseLoadingState implements SurveyResponseStates {}

class SurveyResponseSuccessState implements SurveyResponseStates {
  final Survey survey;

  SurveyResponseSuccessState(this.survey);
}

class GetSurveyResponseListSuccessState implements SurveyResponseStates {
  final List<SurveyResponse> surveyResponseList;

  GetSurveyResponseListSuccessState(this.surveyResponseList);
}

class SurveyResponseErrorState implements SurveyResponseStates {
  final SurveyErrors error;

  SurveyResponseErrorState(this.error);
}
