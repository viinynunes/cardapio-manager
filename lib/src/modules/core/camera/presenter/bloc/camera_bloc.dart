import 'package:cardapio_manager/src/modules/core/camera/presenter/bloc/events/camera_events.dart';
import 'package:cardapio_manager/src/modules/core/camera/presenter/bloc/states/camera_states.dart';
import 'package:cardapio_manager/src/modules/core/camera/services/i_camera_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraBloc extends Bloc<CameraEvents, CameraStates> {
  final IImageService imageService;

  CameraBloc(this.imageService) : super(CameraIdleState()) {
    on<PickImageEvent>((event, emit) async {
      final cameraResult = await imageService.getImage(event.imageFrom);

      cameraResult.fold(
          (l) => emit(CameraErrorState(l)), (r) => emit(CameraSuccessState(r)));
    });
  }
}
