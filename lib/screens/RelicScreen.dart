import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_crusade/components/RequisitionItemComponent.dart';
import 'package:my_crusade/models/ArmyUnitModel.dart';
import 'package:my_crusade/models/RelicModel.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';

class RelicScreen extends StatefulWidget {
  static String tag = '/RelicScreen';

  RelicModel? relic;
  ArmyUnitModel? model;

  RelicScreen({this.relic, this.model});

  @override
  RelicScreenState createState() => RelicScreenState();
}

class RelicScreenState extends State<RelicScreen> {

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
            widget.relic!.relicName.validate(),
            color: crusadeApp.isDarkMode ? scaffoldColorDark:colorPrimary,
            textColor: whiteColor,
            actions: [
              IconButton(
                  onPressed: () async {
                    await relicDBService.removeDocument(widget.relic!.id);
                    finish(context);
                  },
                  color: crusadeApp.isDarkMode ? Colors.white : scaffoldSecondaryDark,
                  icon: Icon(Icons.delete)),
            ]
          ),
          body: Observer(
              builder: (_) => SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RequisitionItemComponent(reqName: "Description", reqDesc: widget.relic!.relicDesc.validate()),
                      RequisitionItemComponent(reqName: "Unit", reqDesc: widget.model!.unitName.validate(),)
                    ]
                ),
              )
          )
      ),
    );
  }
}
