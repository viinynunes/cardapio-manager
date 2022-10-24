import 'package:dartz/dartz.dart';

import '../../errors/survey_errors.dart';
import '../entities/survey.dart';

abstract class ISurveyRepository {
  Future<Either<SurveyErrors, List<Survey>>> getSurveyList();

  Future<Either<SurveyErrors, Survey>> createSurvey(Survey survey);

  Future<Either<SurveyErrors, Survey>> updateSurvey(Survey survey);
}
