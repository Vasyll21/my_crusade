import 'package:flutter/material.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/ArmyModel.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/models/UserModel.dart';
import 'package:my_crusade/screens/ArmyScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:nb_utils/nb_utils.dart';

class ArmyItemComponent extends StatefulWidget {
  final ArmyModel? army;

  ArmyItemComponent({this.army});

  @override
  ArmyItemComponentState createState() => ArmyItemComponentState();
}

class ArmyItemComponentState extends State<ArmyItemComponent> {
  UserModel? user;
  CrusadeModel? crusade;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await 2.microseconds.delay;
    crusade = await crusadeDBService.getCrusadeById(widget.army!.crusadeId);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
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
                title: Text(widget.army!.armyName.validate()),
                subtitle: Text('fraction: ${widget.army!.fraction.validate()}'),
              ),
            ],
          ).paddingAll(8),
        ],
      ),
    ).onTap(() {
      hideKeyboard(context);
      ArmyScreen(crusadeData:crusade, armyData: widget.army).launch(context);
    }, highlightColor: crusadeApp.isDarkMode ? scaffoldColorDark : context.cardColor);
  }
}
