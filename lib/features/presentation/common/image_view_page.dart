import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';

class ImageViewPage extends StatelessWidget {
  final String? imagePath;
  const ImageViewPage({
    super.key,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '',
        withBackButton: true,
      ),
      body: InteractiveViewer(
        child: SizedBox(
          height: double.infinity,
          child: imagePath != null
              ? Container(
                width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(imagePath!)),
                    ),
                  ),
                )
              : Image.asset(
                  AssetPath.getImages('sample.png'),
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
        ),
      ),
    );
  }
}
