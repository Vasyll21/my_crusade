import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:my_crusade/models/ArmyModel.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/screens/ArmyUnitsScreen.dart';
import 'package:my_crusade/screens/CreateArmyScreen.dart';
import 'package:my_crusade/screens/CrusadeMenuScreen.dart';
import 'package:my_crusade/screens/RelicsScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';
import 'RequisitionsScreen.dart';

class ArmyScreen extends StatefulWidget {
  static String tag = '/ArmyScreen';

  CrusadeModel? crusadeData;
  ArmyModel? armyData;

  ArmyScreen({this.crusadeData, this.armyData});

  @override
  ArmyScreenState createState() => ArmyScreenState();
}

class ArmyScreenState extends State<ArmyScreen> {

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(crusadeApp.isDarkMode ? scaffoldColorDark : colorPrimary, statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    setStatusBarColor(crusadeApp.isDarkMode ? scaffoldColorDark : Colors.white);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: appBarWidget(
            widget.armyData!.armyName.validate(),
            color: crusadeApp.isDarkMode ? scaffoldColorDark:colorPrimary,
            textColor: whiteColor,
          ),
          body: Observer(
              builder: (_) => SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SettingItemWidget(
                        leading: Icon(CupertinoIcons.pen),
                        title: 'Crusade: ${widget.crusadeData!.crusadeName}',
                        onTap: () => {
                            CrusadeMenuScreen(crusade: widget.crusadeData!).launch(context)
                          },
                      ),
                      Divider(height: 0),
                      SettingItemWidget(
                        leading: Icon(MaterialCommunityIcons.sword_cross),
                        title: 'Your units',
                        onTap: () => {
                          ArmyUnitsScreen(armyData: widget.armyData!).launch(context)
                        },
                      ),
                      Divider(height: 0),
                      SettingItemWidget(
                        leading: Icon(Icons.star),
                        title: 'Requisition Points: ${widget.armyData!.reqPoints}',
                        onTap: () => {
                          RequisitionsScreen(armyData: widget.armyData!, crusadeData: widget.crusadeData!).launch(context)
                        },
                      ),
                      Divider(height: 0),
                      SettingItemWidget(
                        leading: Icon(Icons.star),
                        title: 'Relics',
                        onTap: () => {
                          RelicsScreen(army: widget.armyData!).launch(context)
                        },
                      ),
                    ]
                ),
              )
          )
      ),
    );
  }
}
