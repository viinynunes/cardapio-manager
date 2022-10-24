import 'package:cardapio_manager/src/modules/survey/domain/entities/survey.dart';
import 'package:cardapio_manager/src/modules/survey/domain/entities/survey_response.dart';
import 'package:cardapio_manager/src/modules/survey/errors/survey_errors.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/i_survey_repository.dart';
import '../i_survey_usecase.dart';

class SurveyUsecaseImpl implements ISurveyUsecase {
  final ISurveyRepository _repository;

  SurveyUsecaseImpl(this._repository);

  @override
  Future<Either<SurveyErrors, Survey>> createSurvey(Survey survey) async {
    if (survey.title.isEmpty || survey.title.length < 2) {
      return Left(SurveyErrors('Invalid Title'));
    }

    return _repository.createSurvey(survey);
  }

  @override
  Future<Either<SurveyErrors, List<Survey>>> getSurveyList() async {
    return _repository.getSurveyList();
  }

  @override
  Future<Either<SurveyErrors, Survey>> updateSurvey(Survey survey) async {
    if (survey.title.isEmpty || survey.title.length < 2) {
      return Left(SurveyErrors('Invalid Title'));
    }

    return _repository.updateSurvey(survey);
  }

  @override
  Future<Either<SurveyErrors, Survey>> enableSurvey(Survey survey) {
    return _repository.enableSurvey(survey);
  }

  @override
  Future<Either<SurveyErrors, List<SurveyResponse>>>
      getSurveyResponseListBySurvey(Survey survey) async {
    if (survey.id.isEmpty) {
      return Left(SurveyErrors('Invalid client'));
    }

    return _repository.getSurveyResponseListBySurvey(survey);
  }
}
