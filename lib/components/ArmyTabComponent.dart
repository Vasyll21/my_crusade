import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/ArmyModel.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/screens/ArmyUnitsScreen.dart';
import 'package:my_crusade/screens/CrusadeMenuScreen.dart';
import 'package:my_crusade/screens/RelicsScreen.dart';
import 'package:my_crusade/screens/RequisitionsScreen.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class ArmyTabComponent extends StatefulWidget {
  static String tag = '/ArmyTabComponent';

  CrusadeModel? crusadeData;

  ArmyTabComponent({this.crusadeData});

  @override
  ArmyTabComponentState createState() => ArmyTabComponentState();
}

class ArmyTabComponentState extends State<ArmyTabComponent> {

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ArmyModel>(
        future: armyDBService.getUserArmyInCrusade(crusadeApp.userId, widget.crusadeData!.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text(snapshot.error.toString()).center();
          if (snapshot.hasData) {
            if (snapshot.data! == null) {
              return noDataWidget(errorMessage: "No Army in this Crusade");
            } else {
              return Observer(
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
                              ArmyUnitsScreen(armyData: snapshot.data!).launch(context)
                            },
                          ),
                          Divider(height: 0),
                          SettingItemWidget(
                            leading: Icon(Icons.star),
                            title: 'Requisition Points: ${snapshot.data!.reqPoints}',
                            onTap: () => {
                              RequisitionsScreen(armyData: snapshot.data!, crusadeData: widget.crusadeData!).launch(context)
                            },
                          ),
                          Divider(height: 0),
                          SettingItemWidget(
                            leading: Icon(Icons.star),
                            title: 'Relics',
                            onTap: () => {
                              RelicsScreen(army: snapshot.data!).launch(context)
                            },
                          ),
                        ]
                    ),
                  )
              );
            }
          }
          return Loader().center();
        });
  }
}
