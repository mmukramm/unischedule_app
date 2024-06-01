import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';

class ImageViewPage extends StatelessWidget {
  const ImageViewPage({super.key});

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
          child: Image.asset(
            AssetPath.getImages('sample.png'),
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
