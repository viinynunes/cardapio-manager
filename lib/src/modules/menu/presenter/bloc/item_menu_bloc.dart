import 'package:cardapio_manager/src/modules/menu/presenter/bloc/events/item_menu_events.dart';
import 'package:cardapio_manager/src/modules/menu/presenter/bloc/states/item_menu_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/i_item_menu_usecase.dart';
import '../../services/i_item_menu_services.dart';

class ItemMenuBloc extends Bloc<ItemMenuEvents, ItemMenuStates> {
  final IItemMenuUsecase itemUsecase;
  final IItemMenuService itemService;

  ItemMenuBloc(this.itemUsecase, this.itemService)
      : super(ItemMenuIdleState()) {
    on<GetItemMenuListEvent>((event, emit) async {
      emit(ItemMenuLoadingState());

      final result = await itemUsecase.findByWeekday(event.weekday);

      result.fold((l) => emit(ItemMenuErrorState(l)),
          (r) => emit(ItemMenuGetListSuccessState(r)));
    });

    on<CreateItemMenuEvent>((event, emit) async {
      emit(ItemMenuLoadingState());

      final result = await itemUsecase.create(event.itemMenu);

      result.fold((l) => emit(ItemMenuErrorState(l)),
          (r) => emit(ItemMenuCreateOrUpdateSuccessState(r)));
    });

    on<UpdateItemMenuEvent>((event, emit) async {
      emit(ItemMenuLoadingState());

      final result = await itemUsecase.update(event.itemMenu);

      result.fold((l) => emit(ItemMenuErrorState(l)),
          (r) => emit(ItemMenuCreateOrUpdateSuccessState(r)));
    });

    on<FilterItemMenuListEvent>((event, emit) {
      emit(ItemMenuLoadingState());

      final menuList =
          itemService.searchFilter(event.menuList, event.searchText);

      emit(ItemMenuGetFilteredListSuccessState(menuList));
    });

    on<GetItemMenuListByStatusEvent>((event, emit) async {
      emit(ItemMenuLoadingState());

      final result = event.enabled
          ? await itemUsecase.findAllEnabledByWeekday(event.weekday)
          : await itemUsecase.findAllDisabledByWeekday(event.weekday);

      result.fold((l) => emit(ItemMenuErrorState(l)),
          (r) => emit(ItemMenuGetListSuccessState(r)));
    });
  }
}
