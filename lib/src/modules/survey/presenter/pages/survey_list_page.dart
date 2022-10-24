import 'package:cardapio_manager/src/modules/core/drawer/presenter/custom_drawer.dart';
import 'package:cardapio_manager/src/modules/survey/presenter/pages/tiles/survey_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/survey.dart';
import '../bloc/events/survey_events.dart';
import '../bloc/states/survey_states.dart';
import '../bloc/survey_bloc.dart';

class SurveyListPage extends StatefulWidget {
  const SurveyListPage({Key? key}) : super(key: key);

  @override
  State<SurveyListPage> createState() => _SurveyListPageState();
}

class _SurveyListPageState extends State<SurveyListPage>
    with TickerProviderStateMixin {
  final bloc = Modular.get<SurveyBloc>();

  @override
  void initState() {
    super.initState();

    bloc.add(GetSurveyListEvent());
  }

  createOrUpdateSurvey({Survey? survey}) async {
    final result = await Modular.to
        .pushNamed('./survey-registration-page/', arguments: [survey]);

    if (result != null && result is Survey) {
      if (survey != null) {
        bloc.add(UpdateSurveyEvent(result));
      } else {
        bloc.add(CreateSurveyEvent(result));
      }
    }
    bloc.add(GetSurveyListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Pesquisa de Satisfação'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await createOrUpdateSurvey();
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<SurveyBloc, SurveyStates>(
        bloc: bloc,
        builder: (context, state) {
          if (state is SurveyLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is SurveyErrorState) {
            return Center(
              child: Text(state.error.message),
            );
          }

          if (state is GetSurveyListSuccessState) {
            final surveyList = state.surveyList;

            return surveyList.isNotEmpty
                ? ListView.builder(
                    itemCount: surveyList.length,
                    itemBuilder: (_, index) {
                      final survey = surveyList[index];
                      return SurveyListTile(
                          survey: survey,
                          onTap: () async =>
                              await createOrUpdateSurvey(survey: survey));
                    },
                  )
                : const Center(
                    child: Text('Nenhuma pesquisa encontrada'),
                  );
          }

          return Container();
        },
      ),
    );
  }
}
