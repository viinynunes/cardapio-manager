import '../../../domain/entities/survey.dart';

abstract class SurveyEvents {}

class GetSurveyListEvent implements SurveyEvents {}

class CreateSurveyEvent implements SurveyEvents {
  final Survey survey;

  CreateSurveyEvent(this.survey);
}

class UpdateSurveyEvent implements SurveyEvents {
  final Survey survey;

  UpdateSurveyEvent(this.survey);
}

class EnableSurveyEvent implements SurveyEvents {
  final Survey survey;

  EnableSurveyEvent(this.survey);
}
