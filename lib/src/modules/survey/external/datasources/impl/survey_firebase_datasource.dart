import 'package:cardapio_manager/src/modules/survey/infra/models/survey_response_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../infra/datasources/i_survey_datasource.dart';
import '../../../infra/models/survey_model.dart';

class SurveyFirebaseDatasourceImpl implements ISurveyDatasource {
  final _surveyCollection = FirebaseFirestore.instance.collection('survey');

  @override
  Future<SurveyModel> createSurvey(SurveyModel survey) async {
    _surveyCollection.add(survey.toMap()).then((value) async {
      survey.id = value.id;
      await _surveyCollection.doc(survey.id).set(survey.toMap());
    });

    return survey;
  }

  @override
  Future<List<SurveyModel>> getSurveyList() async {
    List<SurveyModel> surveyList = [];

    final result = await _surveyCollection.get();

    for (var e in result.docs) {
      surveyList.add(SurveyModel.fromMap(e.data()));
    }

    return surveyList;
  }

  @override
  Future<SurveyModel> updateSurvey(SurveyModel survey) async {
    await _surveyCollection.doc(survey.id).set(survey.toMap());

    return survey;
  }

  @override
  Future<SurveyModel> enableSurvey(SurveyModel survey) async {
    final snap =
        await _surveyCollection.where('enabled', isEqualTo: true).get();

    for (var index in snap.docs) {
      await _surveyCollection.doc(index.id).update({'enabled': false});
    }

    return await updateSurvey(survey);
  }

  @override
  Future<List<SurveyResponseModel>> getSurveyResponseListBySurvey(
      SurveyModel survey) async {
    List<SurveyResponseModel> surveyList = [];

    final snap =
        await _surveyCollection.doc(survey.id).collection('responses').get();

    for (var index in snap.docs) {
      surveyList.add(SurveyResponseModel.fromMap(index.data()));
    }

    return surveyList;
  }
}
