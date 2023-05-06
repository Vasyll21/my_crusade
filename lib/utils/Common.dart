import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../main.dart';
import 'Constants.dart';

Widget placeHolderWidget({double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment, double? radius}) {
  return Image.asset('assets/placeholder.jpg', height: height, width: width, fit: fit ?? BoxFit.cover, alignment: alignment ?? Alignment.center).cornerRadiusWithClipRRect(radius ?? defaultRadius);
}

bool isLoggedInWithApp() {
  return crusadeApp.isLoggedIn && getStringAsync(LOGIN_TYPE) == LoginTypeApp;
}

Future<void> saveOneSignalPlayerId() async {
  await OneSignal.shared.getDeviceState().then((value) async {
    if (value!.userId.validate().isNotEmpty) await setValue(PLAYER_ID, value.userId.validate());
  });
}
