import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';

class InternalServerError extends StatelessWidget {
  final String message;
  final double? height;
  const InternalServerError({
    super.key,
    required this.message,
    this.height = 220,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        SvgPicture.asset(
          AssetPath.getSvg('internal-server-error.svg'),
          height: height,
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: textTheme.titleMedium,
        )
      ],
    );
  }
}