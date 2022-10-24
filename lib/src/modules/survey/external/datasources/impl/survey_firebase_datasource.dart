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
}
