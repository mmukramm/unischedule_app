import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/features/presentation/user/activity/activity_page.dart';
import 'package:unischedule_app/features/presentation/user/activity_history/activity_history_page.dart';
import 'package:unischedule_app/features/presentation/user/profile/profile_page.dart';

class UserMainMenu extends StatefulWidget {
  const UserMainMenu({super.key});

  @override
  State<UserMainMenu> createState() => _UserMainMenuState();
}

class _UserMainMenuState extends State<UserMainMenu> {
  late final List<Widget> pages;

  late int _currentIndexMenu;

  @override
  void initState() {
    super.initState();
    pages = [
      const ActivityPage(),
      const ActivityHistoryPage(),
      const ProfilePage(),
    ];

    _currentIndexMenu = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndexMenu],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: scaffoldColor,
          currentIndex: _currentIndexMenu,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: primaryTextColor,
          unselectedItemColor: backgroundColor,
          onTap: (pageIndex) {
            setState(() {
              _currentIndexMenu = pageIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: 'Activity',
              icon: Container(
                margin: const EdgeInsets.only(bottom: 4, top: 2),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: _currentIndexMenu == 0 ? primaryColor : backgroundColor,
                ),
                child: SvgPicture.asset(
                  colorFilter: ColorFilter.mode(
                    _currentIndexMenu == 0 ? primaryTextColor : scaffoldColor,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  AssetPath.getIcons(
                    'play-circle.svg',
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: 'History Activity',
              backgroundColor: primaryColor,
              icon: Container(
                margin: const EdgeInsets.only(bottom: 4, top: 2),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: _currentIndexMenu == 1 ? primaryColor : backgroundColor,
                ),
                child: SvgPicture.asset(
                  colorFilter: ColorFilter.mode(
                    _currentIndexMenu == 1 ? primaryTextColor : scaffoldColor,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  AssetPath.getIcons(
                    'history.svg',
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Container(
                margin: const EdgeInsets.only(bottom: 4, top: 2),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: _currentIndexMenu == 2 ? primaryColor : backgroundColor,
                ),
                child: SvgPicture.asset(
                  colorFilter: ColorFilter.mode(
                    _currentIndexMenu == 2 ? primaryTextColor : scaffoldColor,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  AssetPath.getIcons(
                    'user.svg',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
