import 'package:cardapio_manager/src/modules/menu/errors/item_menu_errors.dart';
import 'package:dartz/dartz.dart';

import '../../entities/weekday.dart';
import '../i_days_of_week_usecase.dart';

class DaysOfWeekUsecaseImpl implements IDaysOfWeekUsecase {
  @override
  Either<ItemMenuError, List<Weekday>> call(DateTime today) {
    if (today.weekday <= 0 || today.weekday > 7) {
      return Left(ItemMenuError('Invalid weekday'));
    }

    List<Weekday> list = _getWeekdayList();

    final todayAux =
        list.singleWhere((element) => today.weekday == element.weekday);

    todayAux.selected = true;

    return Right(list);
  }

  _getWeekdayList() {
    return [
      Weekday(1, 'Segunda-Feira', false),
      Weekday(2, 'Terça-Feira', false),
      Weekday(3, 'Quarta-Feira', false),
      Weekday(4, 'Quinta-Feira', false),
      Weekday(5, 'Sexta-Feira', false),
      Weekday(6, 'Sábado', false),
      Weekday(7, 'Domingo', false),
    ];
  }
}
