import '../../domain/entities/survey.dart';

class SurveyModel extends Survey {
  SurveyModel(
      {required super.id,
      required super.title,
      required super.description,
      required super.enabled});

  SurveyModel.fromSurvey(Survey survey)
      : super(
            id: survey.id,
            title: survey.title,
            description: survey.description,
            enabled: survey.enabled);

  SurveyModel.fromMap(Map<String, dynamic> map)
      : super(
            id: map['id'],
            title: map['title'],
            description: map['description'],
            enabled: map['enabled']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'enabled': enabled,
    };
  }
}
