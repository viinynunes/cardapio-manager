import 'package:cardapio_manager/src/modules/order/domain/usecases/impl/order_usecase_impl.dart';
import 'package:cardapio_manager/src/modules/order/external/datasources/impl/order_firebase_datasource.dart';
import 'package:cardapio_manager/src/modules/order/infra/repositories/order_repository_impl.dart';
import 'package:cardapio_manager/src/modules/order/presenter/bloc/order_bloc.dart';
import 'package:cardapio_manager/src/modules/order/presenter/pages/orders_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OrderModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => OrderFirebaseDatasource()),
        Bind((i) => OrderRepositoryImpl(i())),
        Bind((i) => OrderUsecaseImpl(i())),
        Bind((i) => OrderBloc(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const OrdersPage()),
      ];
}
