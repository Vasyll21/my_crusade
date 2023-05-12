import 'package:flutter/material.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/services/AuthService.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';

//import 'DashboardScreen.dart';
import 'DashboardScreen.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await 2.seconds.delay;

    setStatusBarColor(
      crusadeApp.isDarkMode ? scaffoldColorDark : Colors.transparent,
      statusBarIconBrightness: crusadeApp.isDarkMode ? Brightness.light : Brightness.light,
    );

    if (crusadeApp.isLoggedIn) {
      DashboardScreen().launch(context, isNewTask: true);
    } else {
      LoginScreen().launch(context, isNewTask: true);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: crusadeApp.isDarkMode ? scaffoldSecondaryDark : colorPrimary,
      body: Container(
        child: Text(mAppName, style: primaryTextStyle(size: 36, color: Colors.white)),
      ).center(),
    );
  }
}
