import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/camera/presenter/bloc/camera_bloc.dart';
import '../../../../core/camera/presenter/bloc/events/camera_events.dart';
import '../../../../core/camera/presenter/bloc/states/camera_states.dart';
import '../../../../core/camera/presenter/pages/camera_source_animated_selector.dart';
import '../../utils/utils.dart';
import 'file_image_container.dart';
import 'network_image_container.dart';

class ItemMenuPrincipalImageContainer extends StatefulWidget {
  const ItemMenuPrincipalImageContainer({Key? key, required this.getFileImage})
      : super(key: key);

  final Function(File? file) getFileImage;

  @override
  State<ItemMenuPrincipalImageContainer> createState() =>
      _ItemMenuPrincipalImageContainerState();
}

class _ItemMenuPrincipalImageContainerState
    extends State<ItemMenuPrincipalImageContainer>
    with SingleTickerProviderStateMixin {
  final cameraBloc = Modular.get<CameraBloc>();

  late File image;

  late AnimationController cameraSourceAnimatedController;
  late Animation<double> cameraSourceAnimation;

  @override
  void initState() {
    super.initState();

    cameraSourceAnimatedController = AnimationController(vsync: this)
      ..duration = const Duration(milliseconds: 0);
    cameraSourceAnimation = Tween<double>(begin: 0, end: 100)
        .animate(cameraSourceAnimatedController);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: size.height * 0.4,
      child: Stack(
        children: [
          BlocBuilder<CameraBloc, CameraStates>(
            bloc: cameraBloc,
            builder: (context, state) {
              if (state is CameraSuccessState) {
                image = state.file;
                widget.getFileImage(image);
                return FileImageContainer(file: image);
              }
              return const NetworkImageContainer(
                imagePath: URLS.itemMenuNoImageUrl,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CameraSourceAnimatedSelector(
              animation: cameraSourceAnimation,
              onForward: () => cameraSourceAnimatedController.forward(),
              onReverse: () => cameraSourceAnimatedController.reverse(),
              onGallery: () =>
                  cameraBloc.add(PickImageEvent(imageFrom: 'gallery')),
              onCamera: () =>
                  cameraBloc.add(PickImageEvent(imageFrom: 'camera')),
            ),
          ),
        ],
      ),
    );
  }
}
