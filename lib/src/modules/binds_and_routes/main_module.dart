import 'package:cardapio_manager/src/modules/binds_and_routes/item_menu_module.dart';
import 'package:cardapio_manager/src/modules/binds_and_routes/order_module.dart';
import 'package:cardapio_manager/src/modules/core/camera/presenter/bloc/camera_bloc.dart';
import 'package:cardapio_manager/src/modules/core/camera/services/impl/image_picker_service.dart';
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
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: ItemMenuModule()),
        ModuleRoute('/order/', module: OrderModule()),
      ];
}
