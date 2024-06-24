import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';

class DataEmpty extends StatelessWidget {
  final String message;
  const DataEmpty({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        SvgPicture.asset(
          AssetPath.getSvg('data-empty.svg'),
          height: 220,
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: textTheme.titleSmall,
        )
      ],
    );
  }
}