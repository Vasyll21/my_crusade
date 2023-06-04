import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:my_crusade/models/BattleModel.dart';
import 'package:my_crusade/models/UserModel.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';
import 'BattlesScreen.dart';

class BattleScreen extends StatefulWidget {
  static String tag = '/BattleScreen';

  BattleModel? battle;
  String? attacker;
  String? defender;

  BattleScreen({this.battle, this.attacker, this.defender});

  @override
  BattleScreenState createState() => BattleScreenState();
}

class BattleScreenState extends State<BattleScreen> {

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
          widget.battle!.mission.validate(),
          color: crusadeApp.isDarkMode ? scaffoldColorDark:colorPrimary,
          textColor: whiteColor,
        ),
        body: Observer(
          builder: (_) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingItemWidget(
                    leading: Icon(MaterialCommunityIcons.sword),
                    title: 'Attacker: ${widget.attacker}',
                  ),
                  Divider(height: 0),
                  SettingItemWidget(
                    leading: Icon(Icons.shield),
                    title: 'Defender: ${widget.defender}',
                  ),
                  Divider(height: 0),
                  SettingItemWidget(
                    leading: Icon(LineIcons.crown),
                    title: 'Chose Winner',
                    onTap: () async {
                      bool? res = await showConfirmDialog(
                        context,
                        "Who win?",
                        negativeText: "Defender",
                        positiveText: "Attacker",
                      );

                      if (res ?? false) {
                        widget.battle!.winner = widget.battle!.attackerId;
                      }else {
                        widget.battle!.winner = widget.battle!.defenderId;
                      }
                      widget.battle!.hasWinner = true;

                      await battleDBService.updateDocument(widget.battle!.toJson(), widget.battle!.id);
                      BattlesScreen(crusadeId: widget.battle!.crusadeId).launch(context);
                    },
                  ).visible((crusadeApp.isMaster || crusadeApp.userFullName == widget.battle!.attackerId ||
                      crusadeApp.userFullName == widget.battle!.defenderId) && widget.battle!.hasWinner == false),
                  FutureBuilder<UserModel>(
                      future: userDBService.getUserById(widget.battle!.winner),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) return Text(snapshot.error.toString()).center();
                        if (snapshot.hasData) {
                          if (snapshot.data! == null) {
                            return noDataWidget(errorMessage: "No Data");
                          } else {
                            return SettingItemWidget(
                                title: 'Winner: ${snapshot.data!.name.validate()}',
                                leading: Icon(LineIcons.crown)
                            );
                          }
                        }
                        return Loader().center();
                      }).visible(widget.battle!.winner != null),
                ]
            ),
          )
        )
      ),
    );
  }
}