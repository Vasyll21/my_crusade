import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_crusade/services/UserDBService.dart';
import 'package:my_crusade/engine/CrusadeApp.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Common.dart';
import 'package:my_crusade/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'AppTheme.dart';
import 'screens/SplashScreen.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

UserDBService userDBService = UserDBService();

CrusadeApp crusadeApp = CrusadeApp();

String? restaurantName = '';
String? restaurantId = '';

List<String?> favRestaurantList = [];

String userAddressGlobal = '';
String? userCityNameGlobal = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initMethod();

  runApp(MyApp());
}

Future<void> initMethod() async {
  defaultLoaderAccentColorGlobal = colorPrimary;
  sharedPreferences = await SharedPreferences.getInstance();

  if (isMobile) {
    await Firebase.initializeApp();

    await OneSignal.shared.setAppId(mOneSignalAppId);

    OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
      event.complete(event.notification);
    });

    saveOneSignalPlayerId();
  }

  crusadeApp.setDarkMode(crusadeApp.isDarkMode);
  crusadeApp.setNotification(getBoolAsync(IS_NOTIFICATION_ON, defaultValue: true));

  crusadeApp.setLoggedIn(getBoolAsync(IS_LOGGED_IN));
  if (crusadeApp.isLoggedIn) {
    crusadeApp.setUserId(getStringAsync(USER_ID));
    crusadeApp.setMaster(getBoolAsync(MASTER));
    crusadeApp.setFullName(getStringAsync(USER_DISPLAY_NAME));
    crusadeApp.setUserEmail(getStringAsync(USER_EMAIL));
  }

  int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
  if (themeModeIndex == ThemeModeLight) {
    crusadeApp.setDarkMode(false);
  } else if (themeModeIndex == ThemeModeDark) {
    crusadeApp.setDarkMode(true);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setOrientationPortrait();

    return Observer(
      builder: (_) => MaterialApp(
        title: mAppName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: crusadeApp.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: SplashScreen(),
        builder: scrollBehaviour(),
      ),
    );
  }
}
