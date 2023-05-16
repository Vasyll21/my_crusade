import 'package:flutter/material.dart';
import 'package:my_crusade/components/BattleItemComponent.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/BattleModel.dart';
import 'CreateBattleScreen.dart';

class BattlesScreen extends StatefulWidget {
  static String tag = '/BattlesScreen';

  String? crusadeId;

  BattlesScreen({this.crusadeId});

  @override
  BattlesScreenState createState() => BattlesScreenState();
}

class BattlesScreenState extends State<BattlesScreen> {
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
            "Battles List",
            color: crusadeApp.isDarkMode ? scaffoldSecondaryDark : Colors.white,
            textColor: crusadeApp.isDarkMode ? Colors.white : Colors.black,
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => CreateBattleScreen().launch(context),
                color: crusadeApp.isDarkMode ? scaffoldSecondaryDark : Colors.white
              ).visible(crusadeApp.isMaster),
            ]
        ),
        body: StreamBuilder<List<BattleModel>>(
            stream: battleDBService.battlesByCrusade(widget.crusadeId!),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text(snapshot.error.toString()).center();
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return noDataWidget(errorMessage: "No Battles");
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return BattleItemComponent(battle: snapshot.data![index]);
                    },
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data!.length,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                  );
                }
              }
              return Loader().center();
            }),
      ),
    );
  }
}