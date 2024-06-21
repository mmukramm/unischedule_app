import 'package:flutter/material.dart';

import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';

class ActivityItem extends StatelessWidget {
  const ActivityItem({
    super.key,
    required this.data,
  });

  final Map data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: scaffoldColor,
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 12 / 11,
            child: Image.asset(
              AssetPath.getImages(data['image']),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            data['title'],
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: textTheme.titleSmall!.copyWith(
              color: primaryTextColor,
            ),
          )
        ],
      ),
    );
  }
}
