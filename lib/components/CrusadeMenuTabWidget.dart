import 'package:flutter/material.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/screens/AddUserScreen.dart';
import 'package:my_crusade/screens/BattlesScreen.dart';
import 'package:my_crusade/screens/CreateBattleScreen.dart';
import 'package:my_crusade/screens/ParticipantsScreen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

// ignore: must_be_immutable
class CrusadeMenuTabWidget extends StatefulWidget {
  static String tag = '/CrusadeMenuTabWidget';
  CrusadeModel? crusadeData;

  CrusadeMenuTabWidget({this.crusadeData});

  @override
  CrusadeMenuTabWidgetState createState() => CrusadeMenuTabWidgetState();
}

class CrusadeMenuTabWidgetState extends State<CrusadeMenuTabWidget> {

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingItemWidget(

          leading: Icon(Icons.access_time_outlined),
          title: "Battles",
          onTap: () {
            BattlesScreen(crusadeId: widget.crusadeData!.id).launch(context);
          },
        ),
        Divider(height: 0),
        SettingItemWidget(
          leading: Icon(Icons.people_outline),
          title: "Participants",
          onTap: () {
            ParticipantsScreen(crusadeData: widget.crusadeData, usersId: widget.crusadeData!.participantsId).launch(context);
          },
        ),
        Divider(height: 0),
        SettingItemWidget(
          leading: Icon(Icons.add),
          title: "Add Participant",
          onTap: () {
            AddUserScreen(crusadeData: widget.crusadeData).launch(context);
          },
        ).visible(crusadeApp.isMaster),
        Divider(height: 0),
        SettingItemWidget(
          leading: Icon(Icons.add_box_outlined),
          title: "Create New Battle",
          onTap: () {
            CreateBattleScreen(crusadeData: widget.crusadeData!).launch(context);
          },
        ).visible(crusadeApp.isMaster),
      ],
    );
  }
}
