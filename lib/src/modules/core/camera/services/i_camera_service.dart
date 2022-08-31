import 'dart:io';

import 'package:cardapio_manager/src/modules/core/camera/errors/camera_error.dart';
import 'package:dartz/dartz.dart';

abstract class IImageService {
  Future<Either<CameraError, File>> getImage(String imageFrom);
}
