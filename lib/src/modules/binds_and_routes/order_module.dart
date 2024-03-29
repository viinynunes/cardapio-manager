import 'package:cardapio_manager/src/modules/order/domain/usecases/impl/order_usecase_impl.dart';
import 'package:cardapio_manager/src/modules/order/external/datasources/impl/order_firebase_datasource.dart';
import 'package:cardapio_manager/src/modules/order/infra/repositories/order_repository_impl.dart';
import 'package:cardapio_manager/src/modules/order/presenter/bloc/order_bloc.dart';
import 'package:cardapio_manager/src/modules/order/presenter/pages/order_item_page.dart';
import 'package:cardapio_manager/src/modules/order/presenter/pages/orders_page.dart';
import 'package:cardapio_manager/src/modules/order/service/impl/order_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../order/presenter/pages/home_order_details_page.dart';

class OrderModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => OrderServiceImpl()),
        Bind((i) => OrderFirebaseDatasource()),
        Bind((i) => OrderRepositoryImpl(i())),
        Bind((i) => OrderUsecaseImpl(i())),
        Bind((i) => OrderBloc(i(), i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const OrdersPage()),
        ChildRoute('/home-order-details/',
            child: (_, args) => HomeOrderDetailsPage(
                  report: args.data[0],
                  selectedDay: args.data[1],
                )),
        ChildRoute('/order-item-page/',
            child: (_, args) => OrderItemPage(order: args.data[0]))
      ];
}
