import 'package:cardapio_manager/src/modules/core/camera/presenter/bloc/camera_bloc.dart';
import 'package:cardapio_manager/src/modules/core/camera/services/impl/image_picker_service.dart';
import 'package:cardapio_manager/src/modules/menu/domain/usecases/impl/item_menu_usecase_impl.dart';
import 'package:cardapio_manager/src/modules/menu/external/menu_firebase_datasource_impl.dart';
import 'package:cardapio_manager/src/modules/menu/infra/repositories/item_menu_repository_impl.dart';
import 'package:cardapio_manager/src/modules/menu/presenter/bloc/item_menu_bloc.dart';
import 'package:cardapio_manager/src/modules/menu/presenter/pages/item_menu_list_page.dart';
import 'package:cardapio_manager/src/modules/menu/presenter/pages/item_menu_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => ImagePickerService()),
        Bind.factory((i) => CameraBloc(i())),
        Bind((i) => MenuFirebaseDatasourceImpl()),
        Bind((i) => ItemMenuRepositoryImpl(i())),
        Bind((i) => ItemMenuUsecaseImpl(i())),
        Bind((i) => ItemMenuBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const ItemMenuListPage()),
        ChildRoute(
          '/item/',
          child: (_, args) => ItemMenuPage(
            itemMenu: args.data[0],
          ),
        )
      ];
}
