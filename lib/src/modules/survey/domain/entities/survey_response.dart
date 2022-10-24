import '../../../core/client/domain/entities/client.dart';
import 'survey.dart';

class SurveyResponse {
  String id;
  Client client;
  double satisfaction;
  String description;
  Survey survey;

  SurveyResponse(
      {required this.id,
      required this.client,
      required this.satisfaction,
      required this.description,
      required this.survey});
}
