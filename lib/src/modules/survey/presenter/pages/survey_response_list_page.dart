import 'package:cardapio_manager/src/modules/survey/domain/entities/survey.dart';
import 'package:cardapio_manager/src/modules/survey/presenter/pages/tiles/survey_response_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../bloc/events/survey_response_events.dart';
import '../bloc/states/survey_response_states.dart';
import '../bloc/survey_reponse_bloc.dart';

class SurveyResponseListPage extends StatefulWidget {
  const SurveyResponseListPage({Key? key, required this.survey})
      : super(key: key);

  final Survey survey;

  @override
  State<SurveyResponseListPage> createState() => _SurveyResponseListPageState();
}

class _SurveyResponseListPageState extends State<SurveyResponseListPage> {
  final surveyResponseBloc = Modular.get<SurveyResponseBloc>();

  @override
  void initState() {
    super.initState();

    surveyResponseBloc.add(GetSurveyResponsesBySurveyEvent(widget.survey));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.survey.title),
        centerTitle: true,
        actions: [
          BlocBuilder<SurveyResponseBloc, SurveyResponseStates>(
            bloc: surveyResponseBloc,
            builder: (_, state) {
              if (state is GetSurveyResponseListSuccessState) {
                double total = 0;

                for (var response in state.surveyResponseList) {
                  total += response.satisfaction;
                }

                final media = total / state.surveyResponseList.length;

                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Média: ${media.toString()}'),
                  ),
                );
              }

              return Container();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height * 0.85,
          child: BlocBuilder<SurveyResponseBloc, SurveyResponseStates>(
            bloc: surveyResponseBloc,
            builder: (_, state) {
              if (state is SurveyResponseErrorState) {
                return Center(
                  child: Text(state.error.message),
                );
              }

              if (state is GetSurveyResponseListSuccessState) {
                final surveyResponseList = state.surveyResponseList;

                return surveyResponseList.isNotEmpty
                    ? ListView.builder(
                        itemCount: surveyResponseList.length,
                        itemBuilder: (_, index) {
                          final surveyResponse = surveyResponseList[index];

                          return SurveyResponseListTile(
                              surveyResponse: surveyResponse);
                        },
                      )
                    : const Center(
                        child: Text('Nenhuma resposta encontrada'),
                      );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
