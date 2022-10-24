import 'package:cardapio_manager/src/modules/survey/domain/entities/survey_response.dart';
import 'package:flutter/material.dart';

class SurveyResponseListTile extends StatelessWidget {
  const SurveyResponseListTile({Key? key, required this.surveyResponse})
      : super(key: key);

  final SurveyResponse surveyResponse;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Text(
                    'Cliente: ${surveyResponse.client.name}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(
                    'Nota: ${surveyResponse.satisfaction.toString()}',
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Comentário: ${surveyResponse.description}')
          ],
        ),
      ),
    );
  }
}
