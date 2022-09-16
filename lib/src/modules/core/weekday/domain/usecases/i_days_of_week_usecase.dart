import 'package:dartz/dartz.dart';

import '../../../../menu/errors/item_menu_errors.dart';
import '../entities/weekday.dart';

abstract class IDaysOfWeekUsecase {
  Either<ItemMenuError, List<Weekday>> call(DateTime today);
}
