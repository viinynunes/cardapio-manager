import 'package:flutter/material.dart';

class CameraSourceAnimatedSelector extends AnimatedWidget {
  const CameraSourceAnimatedSelector(
      {Key? key,
      required this.animation,
      required this.onForward,
      required this.onReverse,
      required this.onCamera,
      required this.onGallery})
      : super(key: key, listenable: animation);

  final Animation<double> animation;
  final VoidCallback onForward;
  final VoidCallback onReverse;
  final VoidCallback onCamera;
  final VoidCallback onGallery;

  @override
  Widget build(BuildContext context) {
    final Animation<double> cameraSourceAnimation =
        listenable as Animation<double>;

    final size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.only(right: 4),
        width: size.width * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedContainer(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).secondaryHeaderColor),
              curve: Curves.bounceOut,
              width: 50,
              height: cameraSourceAnimation.value,
              duration: const Duration(seconds: 1),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black38),
                child: Column(
                  children: [
                    Flexible(
                      child: IconButton(
                        onPressed: () {
                          onCamera();
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Flexible(
                      child: IconButton(
                        onPressed: () {
                          onGallery();
                        },
                        icon: const Icon(
                          Icons.file_upload,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                cameraSourceAnimation.value != 100 ? onForward() : onReverse();
              },
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor.withOpacity(0.8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('Alterar Foto'),
                  Icon(Icons.camera_alt_rounded),
                ],
              ),
            ),
          ],
        ));
  }
}
