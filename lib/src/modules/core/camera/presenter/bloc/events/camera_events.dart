abstract class CameraEvents {}

class PickImageEvent implements CameraEvents {
  String imageFrom;

  PickImageEvent({required this.imageFrom});
}
