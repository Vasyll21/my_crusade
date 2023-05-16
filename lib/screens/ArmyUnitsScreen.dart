import 'package:flutter/material.dart';
import 'package:my_crusade/components/ArmyRoleComponent.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/ArmyModel.dart';
import 'package:my_crusade/screens/RoleUnitsScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:nb_utils/nb_utils.dart';

class ArmyUnitsScreen extends StatefulWidget {
  static String tag = '/ArmyUnitsScreen';

  ArmyModel? armyData;

  ArmyUnitsScreen({this.armyData});

  @override
  ArmyUnitsScreenState createState() => ArmyUnitsScreenState();
}

class ArmyUnitsScreenState extends State<ArmyUnitsScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setStatusBarColor(
      crusadeApp.isDarkMode ? scaffoldColorDark : white,
      statusBarIconBrightness: crusadeApp.isDarkMode
          ? Brightness.light
          : Brightness.dark,
    );
  }

  @override
  void dispose() {
    setStatusBarColor(
      crusadeApp.isDarkMode ? scaffoldColorDark : white,
      statusBarIconBrightness: crusadeApp.isDarkMode
          ? Brightness.light
          : Brightness.dark,
    );
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: crusadeApp.isDarkMode ? scaffoldSecondaryDark : Colors.white,
      backgroundColor: context.cardColor,
      onRefresh: () async {
        setState(() {});
        await 2.seconds.delay;
      },
      child: Scaffold(
        appBar: appBarWidget(
            "Army Units List",
            color: crusadeApp.isDarkMode ? scaffoldSecondaryDark : Colors.white,
            textColor: crusadeApp.isDarkMode ? Colors.white : Colors.black,
        ),
        body: Column(
          children: [
            ArmyRoleComponent(role: "HQ").onTap(() {
              RoleUnitsScreen(army: widget.armyData, role: "HQ").launch(context);
            }),
            ArmyRoleComponent(role: "Troop").onTap(() {
              RoleUnitsScreen(army: widget.armyData, role: "Troop").launch(context);
            }),
            ArmyRoleComponent(role: "Elite").onTap(() {
              RoleUnitsScreen(army: widget.armyData, role: "Elite").launch(context);
            }),
            ArmyRoleComponent(role: "Fast Attack").onTap(() {
              RoleUnitsScreen(army: widget.armyData, role: "Fast Attack").launch(context);
            }),
            ArmyRoleComponent(role: "Heavy Support").onTap(() {
              RoleUnitsScreen(army: widget.armyData, role: "Heavy Support").launch(context);
            }),
            ArmyRoleComponent(role: "Transport").onTap(() {
              RoleUnitsScreen(army: widget.armyData, role: "Transport").launch(context);
            })
          ],
        )
      ),
    );
  }
}