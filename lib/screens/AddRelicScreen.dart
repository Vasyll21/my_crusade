import 'package:flutter/material.dart';
import 'package:my_crusade/components/UnitItemComponent.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/ArmyModel.dart';
import 'package:my_crusade/models/ArmyUnitModel.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/screens/ChooseRelicScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class AddRelicScreen extends StatefulWidget {
  static String tag = '/AddRelicScreen';

  ArmyModel? army;
  CrusadeModel? crusadeModel;

  AddRelicScreen({this.army, this.crusadeModel});

  @override
  AddRelicScreenState createState() => AddRelicScreenState();
}

class AddRelicScreenState extends State<AddRelicScreen> {

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: crusadeApp.isDarkMode ? scaffoldColorDark : Colors.white,
        appBar: appBarWidget("Add Relic: Select Character", color: context.cardColor),
        body: StreamBuilder<List<ArmyUnitModel>>(
            stream: armyUnitsDBService.characterUnitsInArmy(widget.army!.id!, true),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text(snapshot.error.toString()).center();
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return noDataWidget(errorMessage: "No Units");
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return UnitItemComponent(unit: snapshot.data![index]).onTap(() {
                        ChooseRelicScreen(army: widget.army!, unit: snapshot.data![index], crusade: widget.crusadeModel!).launch(context);
                      });
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
