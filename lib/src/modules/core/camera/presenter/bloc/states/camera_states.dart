import 'dart:io';

import 'package:cardapio_manager/src/modules/core/camera/errors/camera_error.dart';

abstract class CameraStates {}

class CameraIdleState implements CameraStates {}

class CameraLoadingState implements CameraStates {}

class CameraSuccessState implements CameraStates {
  final File file;

  CameraSuccessState(this.file);
}

class CameraErrorState implements CameraStates {
  final CameraError error;

  CameraErrorState(this.error);
}
