import 'package:cardapio_manager/src/modules/survey/domain/usecases/impl/survey_usecase_impl.dart';
import 'package:cardapio_manager/src/modules/survey/external/datasources/impl/survey_firebase_datasource.dart';
import 'package:cardapio_manager/src/modules/survey/infra/repositories/survey_repository_impl.dart';
import 'package:cardapio_manager/src/modules/survey/presenter/bloc/survey_bloc.dart';
import 'package:cardapio_manager/src/modules/survey/presenter/pages/survey_registration_page.dart';
import 'package:cardapio_manager/src/modules/survey/presenter/pages/survey_list_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SurveyModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => SurveyFirebaseDatasourceImpl()),
        Bind((i) => SurveyRepositoryImpl(i())),
        Bind((i) => SurveyUsecaseImpl(i())),
        Bind((i) => SurveyBloc(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const SurveyListPage()),
        ChildRoute('/survey-registration-page/',
            child: (_, args) => SurveyRegistrationPage(survey: args.data[0])),
      ];
}
