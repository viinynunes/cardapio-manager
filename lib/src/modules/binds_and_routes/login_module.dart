import 'package:cardapio_manager/src/modules/core/auth/domain/usecases/impl/login_usecase_impl.dart';
import 'package:cardapio_manager/src/modules/core/auth/external/login_firebase_datasource_impl.dart';
import 'package:cardapio_manager/src/modules/core/auth/infra/repositories/login_repository_impl.dart';
import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/login_bloc.dart';
import 'package:cardapio_manager/src/modules/core/auth/presenter/pages/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginFirebaseDatasourceImpl()),
        Bind((i) => LoginRepositoryImpl(i())),
        Bind((i) => LoginUsecaseImpl(i())),
        Bind((i) => LoginBloc(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const LoginPage()),
      ];
}
