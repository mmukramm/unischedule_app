import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/features/presentation/widget/loading.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';

class ImageViewPage extends StatelessWidget {
  final String? imagePath;
  final bool isFile;

  const ImageViewPage({
    super.key,
    this.imagePath,
    this.isFile = false,
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
              ? !isFile
                  ? SizedBox(
                      child: CachedNetworkImage(
                        imageUrl: imagePath!,
                        placeholder: (_, __) => const Padding(
                          padding: EdgeInsets.all(20),
                          child: Loading(
                            color: scaffoldColor,
                          ),
                        ),
                        errorWidget: (_, __, ___) => Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            AssetPath.getImages('no-image.jpg'),
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                        fit: BoxFit.contain,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(
                            File(imagePath!),
                          ),
                        ),
                      ),
                    )
              : Image.asset(
                  AssetPath.getImages('no-image.jpg'),
                  fit: BoxFit.contain,
                ),
        ),
      ),
    );
  }
}
