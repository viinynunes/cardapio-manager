import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/camera/presenter/bloc/camera_bloc.dart';
import '../../../../core/camera/presenter/bloc/events/camera_events.dart';
import '../../../../core/camera/presenter/bloc/states/camera_states.dart';
import '../../utils/utils.dart';
import 'file_image_container.dart';
import 'network_image_container.dart';

class ItemMenuPrincipalImageContainer extends StatefulWidget {
  const ItemMenuPrincipalImageContainer({Key? key}) : super(key: key);

  @override
  State<ItemMenuPrincipalImageContainer> createState() =>
      _ItemMenuPrincipalImageContainerState();
}

class _ItemMenuPrincipalImageContainerState
    extends State<ItemMenuPrincipalImageContainer> with SingleTickerProviderStateMixin{
  final cameraBloc = Modular.get<CameraBloc>();

  late File image;

  late AnimationController cameraSourceAnimatedController;
  late Animation<double> cameraSourceAnimation;

  @override
  void initState() {
    super.initState();

    cameraSourceAnimatedController = AnimationController(vsync: this);
    cameraSourceAnimatedController.duration = const Duration(milliseconds: 0);
    cameraSourceAnimation = Tween<double>(begin: 0, end: 100)
        .animate(cameraSourceAnimatedController);

    cameraSourceAnimation.addStatusListener((status) {
      setState(() {});
    });
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
            builder: (_, state) {
              if (state is CameraSuccessState) {
                image = state.file;
                return FileImageContainer(file: image);
              }

              return const NetworkImageContainer(
                imagePath: URLS.itemMenuNoImageUrl,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
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
                      curve: Curves.elasticOut,
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
                                  cameraBloc
                                      .add(PickImageEvent(imageFrom: 'camera'));
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
                                  cameraBloc.add(
                                      PickImageEvent(imageFrom: 'gallery'));
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
                        cameraSourceAnimatedController.forward();
                      },
                      style: ElevatedButton.styleFrom(
                          primary:
                              Theme.of(context).primaryColor.withOpacity(0.8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text('Alterar Foto'),
                          Icon(Icons.camera_alt_rounded),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
