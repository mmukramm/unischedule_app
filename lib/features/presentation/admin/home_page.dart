import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/user/profile/profile_page.dart';
import 'package:unischedule_app/features/presentation/widget/ink_well_container.dart';
import 'package:unischedule_app/features/presentation/admin/user/users_management_page.dart';
import 'package:unischedule_app/features/presentation/admin/activity/activity_management_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        withBackButton: false,
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: scaffoldColor,
                border: Border.all(
                  color: primaryColor,
                  width: 3,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => navigatorKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (_) => const ProfilePage(
                          withBackButton: true,
                        ),
                      ),
                    ),
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: secondaryTextColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: primaryColor,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          width: 80,
                          AssetPath.getIcons('user.svg'),
                          colorFilter: const ColorFilter.mode(
                            primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat Datang",
                        style: textTheme.titleLarge!.copyWith(
                          color: secondaryTextColor,
                        ),
                      ),
                      Text(
                        "Admin Unischedule",
                        style: textTheme.bodyLarge!.copyWith(
                          color: primaryTextColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Divider(
              color: scaffoldColor,
              thickness: 2,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InkWellContainer(
                    padding: const EdgeInsets.all(12),
                    border: Border.all(
                        color: primaryColor,
                        width: 3,
                        strokeAlign: BorderSide.strokeAlignOutside),
                    borderRadiusGeometry: const BorderRadius.only(
                      topRight: Radius.circular(24),
                    ),
                    containerBackgroundColor: scaffoldColor,
                    onTap: () => navigatorKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (context) => const UsersManagementPage(),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          width: 40,
                          AssetPath.getIcons('user.svg'),
                          colorFilter: const ColorFilter.mode(
                            secondaryTextColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Kelola User",
                          style: textTheme.titleLarge!.copyWith(
                            color: primaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: InkWellContainer(
                    padding: const EdgeInsets.all(12),
                    border: Border.all(
                      color: primaryColor,
                      width: 3,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    borderRadiusGeometry: const BorderRadius.only(
                      topRight: Radius.circular(24),
                    ),
                    containerBackgroundColor: scaffoldColor,
                    onTap: () => navigatorKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (context) => const ActivityManagementPage(),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          width: 40,
                          AssetPath.getIcons('play-circle.svg'),
                          colorFilter: const ColorFilter.mode(
                            secondaryTextColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Kelola Aktivitas",
                          style: textTheme.titleLarge!.copyWith(
                            color: primaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
