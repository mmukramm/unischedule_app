import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final bool withBackButton;
  final bool withDeleteButton;
  final VoidCallback? onTapDeleteButton;

  const CustomAppBar({
    super.key,
    this.title = "UNISCHEDULE",
    this.withBackButton = false,
    this.withDeleteButton = false,
    this.onTapDeleteButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 120,
      title: Text(
        title,
        style: textTheme.headlineSmall!.copyWith(
          color: secondaryTextColor,
        ),
      ),
      surfaceTintColor: primaryColor,
      backgroundColor: primaryColor,
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      actions: [
        withDeleteButton
            ? Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: dangerColor,
                    shape: const RoundedRectangleBorder(),
                  ),
                  icon: SvgPicture.asset(
                    width: 32,
                    height: 32,
                    AssetPath.getIcons('trash-can.svg'),
                    colorFilter: const ColorFilter.mode(
                      scaffoldColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: onTapDeleteButton,
                ),
              )
            : const SizedBox(),
      ],
      leading: withBackButton
          ? IconButton(
              icon: SvgPicture.asset(
                width: 32,
                height: 32,
                AssetPath.getIcons('back-play.svg'),
                colorFilter: const ColorFilter.mode(
                  secondaryTextColor,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () => navigatorKey.currentState!.pop(),
            )
          : null,
    );
  }

  @override
  Widget get child => const SizedBox();

  @override
  Size get preferredSize => const Size.fromHeight(92);
}
