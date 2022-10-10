import 'package:cardapio_manager/src/modules/binds_and_routes/client_module.dart';
import 'package:cardapio_manager/src/modules/binds_and_routes/item_menu_module.dart';
import 'package:cardapio_manager/src/modules/binds_and_routes/login_module.dart';
import 'package:cardapio_manager/src/modules/binds_and_routes/order_module.dart';
import 'package:cardapio_manager/src/modules/core/auth/domain/usecases/impl/logged_user_usecase_impl.dart';
import 'package:cardapio_manager/src/modules/core/auth/domain/usecases/impl/login_usecase_impl.dart';
import 'package:cardapio_manager/src/modules/core/auth/external/logged_user_shared_preferences_datasource.dart';
import 'package:cardapio_manager/src/modules/core/auth/external/login_firebase_datasource_impl.dart';
import 'package:cardapio_manager/src/modules/core/auth/infra/repositories/logged_user_repository_impl.dart';
import 'package:cardapio_manager/src/modules/core/auth/infra/repositories/login_repository_impl.dart';
import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/logged_user_bloc.dart';
import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/login_bloc.dart';
import 'package:cardapio_manager/src/modules/core/camera/presenter/bloc/camera_bloc.dart';
import 'package:cardapio_manager/src/modules/core/camera/services/impl/image_picker_service.dart';
import 'package:cardapio_manager/src/modules/core/reports/domain/usecases/impl/order_report_usecase_impl.dart';
import 'package:cardapio_manager/src/modules/core/reports/external/order_report_firebase_datasource_impl.dart';
import 'package:cardapio_manager/src/modules/core/reports/infra/repositories/order_report_repository_impl.dart';
import 'package:cardapio_manager/src/modules/core/reports/presenter/bloc/order_report_bloc.dart';
import 'package:cardapio_manager/src/modules/home/presenter/pages/home_page.dart';
import 'package:cardapio_manager/src/modules/spash/presenter/pages/initial_splash.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/weekday/domain/usecases/impl/days_of_week_usecase_impl.dart';
import '../core/weekday/presenter/bloc/days_of_week_bloc.dart';

class MainModule extends Module {
  @override
  List<Bind> get binds => [
        //Days of week Dependencies
        Bind((i) => DaysOfWeekUsecaseImpl()),
        Bind((i) => DaysOfWeekBloc(i())),

        //ImageDriver Dependencies
        Bind((i) => ImagePickerService()),
        Bind.factory((i) => CameraBloc(i())),

        //Logged User Shared Preferences
        Bind((i) => LoggedUserSharedPreferencesDatasource()),
        Bind((i) => LoggedUserRepositoryImpl(i())),
        Bind((i) => LoggedUserUsecaseImpl(i())),
        Bind((i) => LoggedUserBloc(i())),

        Bind((i) => LoginFirebaseDatasourceImpl()),
        Bind((i) => LoginRepositoryImpl(i())),
        Bind((i) => LoginUsecaseImpl(i())),
        Bind((i) => LoginBloc(i(), i())),

        //Order Report Dependencies
        Bind((i) => OrderReportFirebaseDatasourceImpl()),
        Bind((i) => OrderReportRepositoryImpl(i())),
        Bind((i) => OrderReportUsecaseImpl(i())),
        Bind((i) => OrderReportBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const InitialSplash()),
        ChildRoute('/home/', child: (_, __) => const HomePage()),
        ModuleRoute('/menu/', module: ItemMenuModule()),
        ModuleRoute('/auth/', module: LoginModule()),
        ModuleRoute('/order/', module: OrderModule()),
        ModuleRoute('/client/', module: ClientModule()),
      ];
}
