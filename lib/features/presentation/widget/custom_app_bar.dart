import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final bool withBackButton;

  const CustomAppBar({
    super.key,
    this.title = "UNISCHEDULE",
    this.withBackButton = false,
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
      centerTitle: true,
      elevation: 0,
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
              onPressed: () {},
            )
          : null,
    );
  }

  @override
  Widget get child => const SizedBox();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}