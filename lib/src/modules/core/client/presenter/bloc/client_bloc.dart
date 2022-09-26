import 'package:cardapio_manager/src/modules/core/client/domain/usecases/i_client_usecase.dart';
import 'package:cardapio_manager/src/modules/core/client/presenter/bloc/events/client_events.dart';
import 'package:cardapio_manager/src/modules/core/client/presenter/bloc/states/client_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientBloc extends Bloc<ClientEvents, ClientStates> {
  final IClientUsecase clientUsecase;

  ClientBloc(this.clientUsecase) : super(ClientIdleState()) {
    on<GetClientListEvent>((event, emit) async {
      emit(ClientLoadingState());

      final result = await clientUsecase.findAll();

      result.fold((l) => emit(ClientErrorState(l)),
          (r) => emit(ClientGetListSuccessState(r)));
    });

    on<CreateOrUpdateClientEvent>((event, emit) async {
      emit(ClientLoadingState());

      final result = event.client.id.isEmpty
          ? await clientUsecase.create(event.client)
          : await clientUsecase.update(event.client);

      result.fold((l) => emit(ClientErrorState(l)),
          (r) => emit(ClientCreateOrUpdateSuccessState(r)));
    });

    on<DisableClient>((event, emit) async {
      emit(ClientLoadingState());

      final result = await clientUsecase.disable(event.client);

      result.fold(
          (l) => emit(ClientErrorState(l)), (r) => emit(ClientSuccessState()));
    });
  }
}
