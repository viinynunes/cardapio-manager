import 'package:dartz/dartz.dart';

import '../../errors/survey_errors.dart';
import '../entities/survey.dart';
import '../entities/survey_response.dart';

abstract class ISurveyRepository {
  Future<Either<SurveyErrors, List<Survey>>> getSurveyList();

  Future<Either<SurveyErrors, List<SurveyResponse>>>
      getSurveyResponseListBySurvey(Survey survey);

  Future<Either<SurveyErrors, Survey>> createSurvey(Survey survey);

  Future<Either<SurveyErrors, Survey>> updateSurvey(Survey survey);

  Future<Either<SurveyErrors, Survey>> enableSurvey(Survey survey);
}
