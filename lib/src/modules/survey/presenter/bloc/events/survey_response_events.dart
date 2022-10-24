import '../../../domain/entities/survey.dart';

abstract class SurveyResponseEvents {}

class GetSurveyResponsesBySurveyEvent implements SurveyResponseEvents {
  final Survey survey;

  GetSurveyResponsesBySurveyEvent(this.survey);
}
