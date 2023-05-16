import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_crusade/components/RequisitionItemComponent.dart';
import 'package:my_crusade/models/ArmyModel.dart';
import 'package:my_crusade/models/ArmyUnitModel.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/models/RelicModel.dart';
import 'package:my_crusade/screens/ArmyScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';

class ChooseRelicScreen extends StatefulWidget {
  static String tag = '/ChooseRelicScreen';

  ArmyUnitModel? unit;
  ArmyModel? army;
  CrusadeModel? crusade;

  ChooseRelicScreen({this.unit, this.army, this.crusade});

  @override
  ChooseRelicScreenState createState() => ChooseRelicScreenState();
}

class ChooseRelicScreenState extends State<ChooseRelicScreen> {

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
            "Add Relic: Select Relic",
            color: crusadeApp.isDarkMode ? scaffoldColorDark:colorPrimary,
            textColor: whiteColor,
          ),
          body: Observer(
              builder: (_) => SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RequisitionItemComponent(reqDesc: "Add 1 to Save, on mortal wound roll D6, on 6 ignore this wound",reqName: "Master-crafted Armour").onTap(() {
                        RelicModel relic = RelicModel();

                        relic.armyId = widget.army!.id!;
                        relic.unitId = widget.unit!.id!;
                        relic.relicDesc = "Add 1 to Save, on mortal wound roll D6, on 6 ignore this wound";
                        relic.relicName = "Master-crafted Armour";

                        relicDBService.addDocument(relic.toJson());


                        ArmyScreen(armyData: widget.army!, crusadeData: widget.crusade!).launch(context);
                      }),
                      RequisitionItemComponent(reqDesc: "Add 2 CP at the start of battle, if this model destroyed reduce your CP by 2",reqName: "Laurels of Victory").onTap(() {
                        RelicModel relic = RelicModel();

                        relic.armyId = widget.army!.id!;
                        relic.unitId = widget.unit!.id!;
                        relic.relicDesc = "Add 2 CP at the start of battle, if this model destroyed reduce your CP by 2";
                        relic.relicName = "Laurels of Victory";

                        relicDBService.addDocument(relic.toJson());
                        ArmyScreen(armyData: widget.army!, crusadeData: widget.crusade!).launch(context);
                      })
                    ]
                ),
              )
          )
      ),
    );
  }
}
