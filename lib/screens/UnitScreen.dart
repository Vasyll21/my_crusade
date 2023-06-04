import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_crusade/components/RequisitionItemComponent.dart';
import 'package:my_crusade/models/ArmyUnitModel.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';

class UnitScreen extends StatefulWidget {
  static String tag = '/UnitScreen';

  ArmyUnitModel? model;

  UnitScreen({this.model});

  @override
  UnitScreenState createState() => UnitScreenState();
}

class UnitScreenState extends State<UnitScreen> {

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
              widget.model!.unitName.validate(),
              color: crusadeApp.isDarkMode ? scaffoldColorDark:colorPrimary,
              textColor: whiteColor,
              actions: [
                IconButton(
                    onPressed: () async {
                      await armyUnitsDBService.removeDocument(widget.model!.id);
                      finish(context);
                    },
                    color: crusadeApp.isDarkMode ? scaffoldSecondaryDark : Colors.white,
                    icon: Icon(Icons.delete))
              ]
          ),
          body: Observer(
              builder: (_) => SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RequisitionItemComponent(reqName: "PointCost", reqDesc: widget.model!.pointCost!.toString()),
                      RequisitionItemComponent(reqName: "Fraction", reqDesc: widget.model!.fraction.validate(),),
                      RequisitionItemComponent(reqName: "Role", reqDesc: widget.model!.role.validate(),),
                    ]
                ),
              )
          )
      ),
    );
  }
}
