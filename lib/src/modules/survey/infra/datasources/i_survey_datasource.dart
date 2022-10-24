import 'package:cardapio_manager/src/modules/survey/infra/models/survey_model.dart';
import 'package:cardapio_manager/src/modules/survey/infra/models/survey_response_model.dart';

abstract class ISurveyDatasource {
  Future<List<SurveyModel>> getSurveyList();

  Future<List<SurveyResponseModel>> getSurveyResponseListBySurvey(
      SurveyModel survey);

  Future<SurveyModel> createSurvey(SurveyModel survey);

  Future<SurveyModel> updateSurvey(SurveyModel survey);

  Future<SurveyModel> enableSurvey(SurveyModel survey);
}
