import 'dart:io';

import 'package:cardapio_manager/src/modules/core/camera/errors/camera_error.dart';
import 'package:cardapio_manager/src/modules/core/camera/services/i_camera_service.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService implements IImageService {
  late final ImagePicker _picker;

  ImagePickerService() {
    _picker = ImagePicker();
  }

  @override
  Future<Either<CameraError, File>> getImage(String imageFrom) async {
    final image = await _picker.pickImage(
      source: imageFrom == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );

    if (image == null) {
      return Left(CameraError('No image selected'));
    }

    return Right(File(image.path));
  }
}
