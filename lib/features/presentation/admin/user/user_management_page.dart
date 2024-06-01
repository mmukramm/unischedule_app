import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unischedule_app/core/extensions/context_extension.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/presentation/admin/user/user_form_page.dart';
import 'package:unischedule_app/features/presentation/user/profile/profile_page.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/custom_selector_dialog.dart';
import 'package:unischedule_app/features/presentation/widget/ink_well_container.dart';

class UserManagementPage extends StatelessWidget {
  const UserManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Daftar User",
        withBackButton: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.showCustomSelectorDialog(
            title: 'Pilih Role',
            message: 'Pilih role user',
            items: [
              SelectorDialogParams(
                label: 'Admin',
                onTap: () {
                  navigatorKey.currentState!.pop();
                  navigatorKey.currentState!.push(
                    MaterialPageRoute(
                      builder: (_) => const UserFormPage(
                        isEdit: false,
                        isAdmin: true,
                      ),
                    ),
                  );
                },
              ),
              SelectorDialogParams(
                label: 'User',
                onTap: () {
                  navigatorKey.currentState!.pop();
                  navigatorKey.currentState!.push(
                    MaterialPageRoute(
                      builder: (_) => const UserFormPage(
                        isEdit: false,
                        isAdmin: false,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
        shape: const RoundedRectangleBorder(),
        backgroundColor: infoColor,
        child: SvgPicture.asset(
          AssetPath.getIcons('plus.svg'),
          colorFilter: const ColorFilter.mode(
            scaffoldColor,
            BlendMode.srcIn,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            InkWellContainer(
              border: Border.all(
                color: primaryColor,
                width: 3,
              ),
              padding: const EdgeInsets.all(12),
              borderRadiusGeometry: const BorderRadius.only(
                topRight: Radius.circular(32),
              ),
              containerBackgroundColor: scaffoldColor,
              onTap: () => navigatorKey.currentState!.push(
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hamid Al-Hafidzurrahman Aljabbar",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleMedium,
                        ),
                        Text(
                          "Mthfdz",
                          style: textTheme.bodyMedium!.copyWith(
                            color: primaryTextColor,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "19028492837",
                                style: textTheme.bodyMedium!.copyWith(
                                  color: primaryTextColor,
                                ),
                              ),
                            ),
                            Text(
                              "Admin",
                              style: textTheme.bodyMedium!.copyWith(
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
