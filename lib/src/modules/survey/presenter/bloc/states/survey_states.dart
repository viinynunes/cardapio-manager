import '../../../domain/entities/survey.dart';
import '../../../errors/survey_errors.dart';

abstract class SurveyStates {}

class SurveyIdleState implements SurveyStates {}

class SurveyLoadingState implements SurveyStates {}

class SurveySuccessState implements SurveyStates {
  final Survey survey;

  SurveySuccessState(this.survey);
}

class GetSurveyListSuccessState implements SurveyStates {
  final List<Survey> surveyList;

  GetSurveyListSuccessState(this.surveyList);
}

class SurveySendResponseSuccessState implements SurveyStates {}

class SurveyErrorState implements SurveyStates {
  final SurveyErrors error;

  SurveyErrorState(this.error);
}
