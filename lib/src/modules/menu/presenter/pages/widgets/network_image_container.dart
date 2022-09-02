import 'package:flutter/material.dart';

class NetworkImageContainer extends StatelessWidget {
  const NetworkImageContainer({Key? key, required this.imagePath})
      : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image:
            DecorationImage(fit: BoxFit.cover, image: NetworkImage(imagePath)),
      ),
    );
  }
}
