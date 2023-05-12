import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:my_crusade/components/ThemeSelectionDialog.dart';
import 'package:my_crusade/services/AuthService.dart';
import 'package:my_crusade/utils/ModalKeys.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import 'EditProfileScreen.dart';
import 'AboutAppScreen.dart';
import 'LoginScreen.dart';

class ProfileFragment extends StatefulWidget {
  static String tag = '/ProfileFragment';

  @override
  ProfileFragmentState createState() => ProfileFragmentState();
}

class ProfileFragmentState extends State<ProfileFragment> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future promoteUser() async{
    crusadeApp.setLoading(true);
    setState(() {});

    Map<String, dynamic> req = {
      CommonKeys.updatedAt: DateTime.now(),
      UserKeys.isMaster: true
    };

    await userDBService.updateDocument(req, crusadeApp.userId).then((value) async {
      crusadeApp.setLoading(false);
      crusadeApp.setMaster(true);
    });
  }

  Future<void> init() async {
//
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              Row(
                children: [
                  Icon(Icons.person_outline, size: 60).cornerRadiusWithClipRRect(defaultRadius),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(crusadeApp.userFullName.validate(), style: boldTextStyle()),
                      Text(crusadeApp.userEmail.validate(), style: secondaryTextStyle()),
                    ],
                  ),
                ],
              ).paddingOnly(left: 16, right: 16).onTap(() {
                EditProfileScreen().launch(context);
              }).visible(crusadeApp.isLoggedIn),
              16.height,
              Divider(height: 0),
              SettingItemWidget(
                leading: Icon(MaterialCommunityIcons.theme_light_dark),
                title: "Select Theme",
                onTap: () async {
                  await showInDialog(
                    context,
                    child: ThemeSelectionDialog(),
                    contentPadding: EdgeInsets.zero,
                    title: Text("Select Theme", style: primaryTextStyle(size: 20)),
                  );
                  setState(() {});
                },
              ),
              Divider(height: 0),
              SettingItemWidget(
                leading: Icon(Icons.support_rounded),
                title: "Promote to Master",
                onTap: () {
                  promoteUser();
                },
              ).visible(crusadeApp.isMaster == false),
              Divider(height: 0),
              SettingItemWidget(
                leading: Icon(Icons.info_outline),
                title: "About",
                onTap: () {
                  AboutAppScreen().launch(context);
                },
              ),
              Divider(height: 0),
              SettingItemWidget(
                title: "Logout",
                leading: Icon(Icons.logout),
                onTap: () async {
                  bool? res = await showConfirmDialog(
                    context,
                    "Do you want to logout?",
                    negativeText: "No",
                    positiveText: "Yes",
                  );

                  if (res ?? false) {
                    logout().then((value) {
                      LoginScreen().launch(context, isNewTask: true);
                    });
                  }
                },
              ).visible(crusadeApp.isLoggedIn),
            ],
          ),
        ),
      ),
    );
  }
}
