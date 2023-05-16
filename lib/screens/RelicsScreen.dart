import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_crusade/components/RequisitionItemComponent.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/ArmyModel.dart';
import 'package:my_crusade/models/ArmyUnitModel.dart';
import 'package:my_crusade/models/RelicModel.dart';
import 'package:my_crusade/screens/RelicScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class RelicsScreen extends StatefulWidget {
  static String tag = '/RelicsScreen';

  ArmyModel? army;

  RelicsScreen({this.army});

  @override
  RelicsScreenState createState() => RelicsScreenState();
}

class RelicsScreenState extends State<RelicsScreen> {

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
        appBar: appBarWidget("Relics", color: context.cardColor),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder<List<RelicModel>>(
                        stream: relicDBService.relicsByArmy(widget.army!.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) return Text(snapshot.error.toString()).center();
                          if (snapshot.hasData) {
                            if (snapshot.data!.isEmpty) {
                              return noDataWidget(errorMessage: "No Relics");
                            } else {
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  return RequisitionItemComponent(reqName: snapshot.data![index].relicName.validate(),reqDesc: snapshot.data![index].relicDesc.validate()).onTap(() async {
                                    ArmyUnitModel unit = await armyUnitsDBService.getArmyUnitById(snapshot.data![index].unitId);

                                    RelicScreen(model: unit!, relic: snapshot.data![index]).launch(context);
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
                  ],
                ),
              ),
            ),
            Observer(builder: (_) => Loader().visible(crusadeApp.isLoading)),
          ],
        ),
      ),
    );
  }
}
