import 'package:cardapio_manager/src/modules/core/client/domain/usecases/impl/client_usecase_impl.dart';
import 'package:cardapio_manager/src/modules/core/client/infra/repositories/client_repository_impl.dart';
import 'package:cardapio_manager/src/modules/core/client/presenter/bloc/client_bloc.dart';
import 'package:cardapio_manager/src/modules/core/client/presenter/pages/client_list_page.dart';
import 'package:cardapio_manager/src/modules/core/client/presenter/pages/client_registration_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/client/external/client_firebase_datasource_impl.dart';

class ClientModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => ClientFirebaseDatasourceImpl()),
        Bind((i) => ClientRepositoryImpl(i())),
        Bind((i) => ClientUsecaseImpl(i())),
        Bind((i) => ClientBloc(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const ClientListPage()),
        ChildRoute(
          '/client-registration/',
          child: (_, args) => ClientRegistrationPage(
            client: args.data[0],
          ),
        ),
      ];
}
