import 'package:flutter/material.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Constants.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

part 'CrusadeApp.g.dart';

class CrusadeApp = _CrusadeApp with _$CrusadeApp;

abstract class _CrusadeApp with Store {
  @observable
  bool isLoggedIn = false;

  @observable
  bool isLoading = false;

  @observable
  bool isNotificationOn = true;

  @observable
  bool isDarkMode = false;

  @observable
  bool isMaster = false;

  @observable
  AppBarTheme appBarTheme = AppBarTheme();

  @observable
  String? userFullName = '';

  @observable
  String? userEmail = '';

  @observable
  String? userId = '';

  @observable
  String? phoneNumber = '';

  @action
  void setLoading(bool val) => isLoading = val;

  @action
  Future<void> setLoggedIn(bool val) async {
    isLoggedIn = val;
    await setValue(IS_LOGGED_IN, val);
  }

  @action
  void setNotification(bool val) {
    isNotificationOn = val;

    setValue(IS_NOTIFICATION_ON, val);

    if (isMobile) {
      // OneSignal.shared.setSubscription(val);
    }
  }

  @action
  Future<void> setUserId(String? val) async {
    userId = val;
    await setValue(USER_ID, val.validate());
  }

  @action
  Future<void> setUserEmail(String? val) async {
    userEmail = val;
    await setValue(USER_EMAIL, val.validate());
  }

  @action
  Future<void> setFullName(String? val) async {
    userFullName = val;
    await setValue(USER_DISPLAY_NAME, val.validate());
  }

  @action
  Future<void> setPhoneNumber(String? val) async {
    phoneNumber = val;
    await setValue(PHONE_NUMBER, val.validate());
  }

  @action
  void setMaster(bool val) {
    isMaster = val;
  }

  Future<void> setDarkMode(bool aIsDarkMode) async {
    isDarkMode = aIsDarkMode;

    if (isDarkMode) {
      textPrimaryColorGlobal = Colors.white;
      textSecondaryColorGlobal = textSecondaryColor;

      defaultLoaderBgColorGlobal = scaffoldSecondaryDark;
      appButtonBackgroundColorGlobal = appButtonColorDark;
      shadowColorGlobal = Colors.white12;

      setStatusBarColor(scaffoldColorDark);
    } else {
      textPrimaryColorGlobal = textPrimaryColor;
      textSecondaryColorGlobal = textSecondaryColor;

      defaultLoaderBgColorGlobal = Colors.white;
      appButtonBackgroundColorGlobal = Colors.white;
      shadowColorGlobal = Colors.black12;

      setStatusBarColor(Colors.white);
    }
  }
}
