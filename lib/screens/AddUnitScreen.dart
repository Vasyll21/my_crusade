import 'package:flutter/material.dart';
import 'package:my_crusade/components/ChooseUnitItemComponent.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/ArmyModel.dart';
import 'package:my_crusade/models/ArmyUnitModel.dart';
import 'package:my_crusade/models/UnitModel.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class AddUnitScreen extends StatefulWidget {
  static String tag = '/AddUnitScreen';

  ArmyModel? army;
  String? role;

  AddUnitScreen({this.army, this.role});

  @override
  AddUnitScreenState createState() => AddUnitScreenState();
}

class AddUnitScreenState extends State<AddUnitScreen> {

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
        appBar: appBarWidget('Add Unit: ${widget.role.validate()}', color: context.cardColor),
        body: StreamBuilder<List<UnitModel>>(
            stream: unitDBService.unitsInByRoleAndFraction(widget.army!.fraction.validate(), widget.role.validate()),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text(snapshot.error.toString()).center();
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return noDataWidget(errorMessage: "No Units");
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return ChooseUnitItemComponent(unit: snapshot.data![index]).visible(widget.army!.currentPoints! + snapshot.data![index].pointCost! <= widget.army!.maxPoints!)
                          .onTap(() {
                            ArmyUnitModel armyUnitModel = ArmyUnitModel();
                            armyUnitModel.fraction = widget.army!.fraction;
                            armyUnitModel.unitName = snapshot.data![index].unitName;
                            armyUnitModel.armyId = widget.army!.id;
                            armyUnitModel.role = widget.role.validate();
                            armyUnitModel.pointCost = snapshot.data![index].pointCost;
                            armyUnitModel.isCharacter = snapshot.data![index].isCharacter;

                            armyUnitsDBService.addDocument(armyUnitModel.toJson());

                            ArmyModel army = widget.army!;

                            army.currentPoints = armyUnitModel.pointCost! + army.currentPoints!;

                            armyDBService.updateDocument(army.toJson(), army.id.validate());

                            finish(context);
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