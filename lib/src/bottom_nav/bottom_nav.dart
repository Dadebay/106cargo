// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../design/app_colors.dart';
import '../screens/explore/explore.dart';
import '../screens/initial/initial.dart';
import '../screens/profile/profile.dart';

class BottomNavAll extends StatefulWidget {
  const BottomNavAll({super.key});

  @override
  State<BottomNavAll> createState() => _BottomNavAllState();
}

class _BottomNavAllState extends State<BottomNavAll> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _NavScreens() {
    return [
      const InitialScreen(),
      const ExploreScreen(),
      const ProfileScreen(),
    ];
  }

  int selectedIndex = 0;
  int index = 0;
  bool icon = false;

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cube_box),
        title: 'Sargyt',
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.compass),
        title: 'Gözleg',
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: 'Profil',
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _NavScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        navBarHeight: 68,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: const NavBarDecoration(
          boxShadow: CupertinoContextMenu.kEndBoxShadow,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        popAllScreensOnTapOfSelectedTab: true,
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}
