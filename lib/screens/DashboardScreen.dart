import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';

import 'CrusadesFragment.dart';
import 'ArmyFragment.dart';
import 'LoginScreen.dart';
import 'ProfileFragment.dart';

class DashboardScreen extends StatefulWidget {
  static String tag = '/DashboardScreen';

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  List<Widget> screens = [
    CrusadesFragment(),
    ArmyFragment(),
    ProfileFragment(),
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(Duration(milliseconds: 400));

    setStatusBarColor(
      context.scaffoldBackgroundColor,
      statusBarIconBrightness: crusadeApp.isDarkMode ? Brightness.light : Brightness.dark,
    );

    int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
    if (themeModeIndex == ThemeModeSystem) {
      crusadeApp.setDarkMode(context.platformBrightness() == Brightness.dark);
    }
    window.onPlatformBrightnessChanged = () {
      if (getIntAsync(THEME_MODE_INDEX) == ThemeModeSystem) {
        crusadeApp.setDarkMode(MediaQuery.of(context).platformBrightness == Brightness.light);
      }
    };
  }

  @override
  void didUpdateWidget(covariant DashboardScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: colorPrimary,
        unselectedItemColor: Colors.grey,
        backgroundColor: crusadeApp.isDarkMode ? scaffoldSecondaryDark : white,
        onTap: (index) {
          if (index == 1 || index == 3) {
            if (!crusadeApp.isLoggedIn) {
              LoginScreen().launch(context);
              return;
            }
          }
          selectedIndex = index;
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedLabelStyle: TextStyle(fontSize: 16),
        unselectedLabelStyle: TextStyle(fontSize: 16),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "My Crusades"),
          BottomNavigationBarItem(icon: Icon(Icons.border_color), label: "My Armies"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
      body: SafeArea(
        child: screens[selectedIndex],
      ),
    );
  }
}
