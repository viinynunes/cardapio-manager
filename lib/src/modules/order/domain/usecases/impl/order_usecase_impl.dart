import 'package:dartz/dartz.dart';

import '../../../errors/order_errors.dart';
import '../../entities/order.dart' as order;
import '../../repositories/i_order_repository.dart';
import '../i_order_usecase.dart';

class OrderUsecaseImpl implements IOrderUsecase {
  final IOrderRepository _repository;

  OrderUsecaseImpl(this._repository);

  @override
  Future<Either<OrderError, order.Order>> cancel(order.Order order) async {
    if (order.status.name == 'closed') {
      return Left(OrderError('Order Already closed'));
    }

    if (order.status.name == 'cancelled') {
      return Left(OrderError('Order Already Cancelled'));
    }

    if (order.id.isEmpty) {
      return Left(OrderError('ID cannot be empty'));
    }

    return _repository.cancel(order);
  }

  @override
  Future<Either<OrderError, List<order.Order>>> getOrders() async {
    return _repository.getOrders();
  }

  @override
  Future<Either<OrderError, List<order.Order>>> getOrdersByDay(DateTime day) async {
    return _repository.getOrdersByDay(day);
  }
}
