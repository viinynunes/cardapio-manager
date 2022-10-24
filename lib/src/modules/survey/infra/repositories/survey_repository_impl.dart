import 'package:cardapio_manager/src/modules/survey/domain/entities/survey.dart';
import 'package:cardapio_manager/src/modules/survey/errors/survey_errors.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/i_survey_repository.dart';
import '../datasources/i_survey_datasource.dart';
import '../models/survey_model.dart';

class SurveyRepositoryImpl implements ISurveyRepository {
  final ISurveyDatasource _datasource;

  SurveyRepositoryImpl(this._datasource);

  @override
  Future<Either<SurveyErrors, Survey>> createSurvey(Survey survey) async {
    try {
      final result =
          await _datasource.createSurvey(SurveyModel.fromSurvey(survey));

      return Right(result);
    } on SurveyErrors catch (e) {
      return Left(e);
    } catch (e) {
      return Left(SurveyErrors(e.toString()));
    }
  }

  @override
  Future<Either<SurveyErrors, List<Survey>>> getSurveyList() async {
    try {
      final result = await _datasource.getSurveyList();

      return Right(result);
    } on SurveyErrors catch (e) {
      return Left(e);
    } catch (e) {
      return Left(SurveyErrors(e.toString()));
    }
  }

  @override
  Future<Either<SurveyErrors, Survey>> updateSurvey(Survey survey) async {
    try {
      final result =
          await _datasource.updateSurvey(SurveyModel.fromSurvey(survey));

      return Right(result);
    } on SurveyErrors catch (e) {
      return Left(e);
    } catch (e) {
      return Left(SurveyErrors(e.toString()));
    }
  }

  @override
  Future<Either<SurveyErrors, Survey>> enableSurvey(Survey survey) async {
    try {
      final result =
          await _datasource.enableSurvey(SurveyModel.fromSurvey(survey));

      return Right(result);
    } on SurveyErrors catch (e) {
      return Left(e);
    } catch (e) {
      return Left(SurveyErrors(e.toString()));
    }
  }
}
