import 'package:flutter/material.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/BattleModel.dart';
import 'package:my_crusade/models/UserModel.dart';
import 'package:my_crusade/screens/BattleScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class BattleItemComponent extends StatefulWidget {
  final BattleModel? battle;

  BattleItemComponent({this.battle});

  @override
  BattleItemComponentState createState() => BattleItemComponentState();
}

class BattleItemComponentState extends State<BattleItemComponent> {
  String? attackerName;
  String? defenderName;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    UserModel attacker = await userDBService.getUserById(widget.battle!.attackerId);
    attackerName = attacker.name;
    UserModel defender = await userDBService.getUserById(widget.battle!.defenderId);
    defenderName = defender.name;
    await 10.microseconds.delay;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: userDBService.getUserById(widget.battle!.attackerId),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text(snapshot.error.toString()).center();
          if (snapshot.hasData) {
            if (snapshot.data! == null) {
              return noDataWidget(errorMessage: "No Data");
            } else {
              return FutureBuilder<UserModel>(
                  future: userDBService.getUserById(widget.battle!.defenderId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return Text(snapshot.error.toString()).center();
                    if (snapshot.hasData) {
                      if (snapshot.data! == null) {
                        return noDataWidget(errorMessage: "No Data");
                      } else {
                        return Container(
                          margin: EdgeInsets.all(8),
                          width: context.width(),
                          decoration: boxDecorationWithRoundedCorners(
                            backgroundColor: context.scaffoldBackgroundColor,
                            boxShadow: defaultBoxShadow(spreadRadius: 0.0, blurRadius: 0.0),
                            border: Border.all(color: context.dividerColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(widget.battle!.mission.validate()),
                                    subtitle: Text('members: ${attackerName.validate()} and ${defenderName.validate()}'),
                                  ),
                                ],
                              ).paddingAll(8),
                            ],
                          ),
                        ).onTap(() {
                          hideKeyboard(context);
                          BattleScreen(battle: widget.battle!, attacker: attackerName, defender: defenderName).launch(context);
                        }, highlightColor: crusadeApp.isDarkMode ? scaffoldColorDark : context.cardColor);
                      }
                    }
                    return Loader().center();
                  });
            }
          }
          return Loader().center();
    });
  }
}
