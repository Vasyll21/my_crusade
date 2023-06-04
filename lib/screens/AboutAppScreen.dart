import 'package:flutter/material.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info/package_info.dart';

import '../main.dart';

class AboutAppScreen extends StatefulWidget {
  static String tag = '/AboutAppScreen';

  @override
  AboutAppScreenState createState() => AboutAppScreenState();
}

class AboutAppScreenState extends State<AboutAppScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(
      crusadeApp.isDarkMode ? scaffoldColorDark : Colors.white,
      statusBarIconBrightness: crusadeApp.isDarkMode ? Brightness.light : Brightness.dark,
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          "About",
          color: crusadeApp.isDarkMode ? scaffoldSecondaryDark : Colors.white,
          textColor: crusadeApp.isDarkMode ? Colors.white : Colors.black,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(mAppName, style: primaryTextStyle(size: 30)),
                16.height,
                Container(decoration: BoxDecoration(color: colorPrimary, borderRadius: radius(4)), height: 4, width: 100),
                16.height,
                Text("Version", style: secondaryTextStyle()),
                FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (_, snap) {
                    if (snap.hasData) {
                      return Text('${snap.data!.version.validate()}', style: primaryTextStyle());
                    }
                    return SizedBox();
                  },
                ),
                16.height,
                Text(
                  mAboutApp,
                  style: primaryTextStyle(size: 14),
                  textAlign: TextAlign.justify,
                ),
                16.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}