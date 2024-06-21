import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/features/presentation/widget/loading.dart';
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
              : Image.asset(
                  AssetPath.getImages('no-image.jpg'),
                  fit: BoxFit.contain,
                ),
        ),
      ),
    );
  }
}
