import 'dart:io';

import 'package:flutter/material.dart';

class FileImageContainer extends StatelessWidget {
  const FileImageContainer({Key? key, required this.file}) : super(key: key);

  final File file;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: FileImage(file),
        ),
      ),
    );
  }
}
