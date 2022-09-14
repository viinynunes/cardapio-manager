import 'package:cardapio_manager/src/modules/binds_and_routes/item_menu_module.dart';
import 'package:cardapio_manager/src/modules/binds_and_routes/order_module.dart';
import 'package:cardapio_manager/src/modules/core/camera/presenter/bloc/camera_bloc.dart';
import 'package:cardapio_manager/src/modules/core/camera/services/impl/image_picker_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => ImagePickerService()),
        Bind.factory((i) => CameraBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: ItemMenuModule()),
        ModuleRoute('/order/', module: OrderModule()),
      ];
}
