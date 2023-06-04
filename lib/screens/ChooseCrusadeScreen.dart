import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_crusade/components/ChooseCrusadeItemComponent.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/ArmyModel.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/screens/ChooseArmyNameScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class ChooseCrusadeScreen extends StatefulWidget {
  static String tag = '/ChooseCrusadeScreen';

  String? fraction;

  ChooseCrusadeScreen({this.fraction});

  @override
  ChooseCrusadeScreenState createState() => ChooseCrusadeScreenState();
}

class ChooseCrusadeScreenState extends State<ChooseCrusadeScreen> {

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
        appBar: appBarWidget("Create Army: Select crusade", color: context.cardColor),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                    children: [
                      StreamBuilder<List<ArmyModel>>(
                        stream: armyDBService.armiesByUser(crusadeApp.userId),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) return Text(snapshot.error
                              .toString()).center();
                          if (snapshot.hasData) {
                            if (snapshot.data!.isEmpty) {
                              return StreamBuilder<List<CrusadeModel>>(
                                  stream: crusadeDBService.crusadesByUser(crusadeApp.userId),
                                  builder: (context, snapshotCrusades) {
                                    if (snapshotCrusades.hasError) return Text(snapshotCrusades.error.toString()).center();
                                    if (snapshotCrusades.hasData) {
                                      if (snapshotCrusades.data!.isEmpty) {
                                        return noDataWidget(errorMessage: "No Crusades");
                                      } else {
                                        return ListView.builder(
                                          itemBuilder: (context, index) {
                                            return ChooseCrusadeItemComponent(crusade: snapshotCrusades.data![index]).onTap(() => {
                                              ChooseArmyNameScreen(fraction: widget.fraction.validate(), crusadeData: snapshotCrusades.data![index]).launch(context)
                                            });
                                          },
                                          padding: EdgeInsets.all(8),
                                          itemCount: snapshotCrusades.data!.length,
                                          physics: ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                        );
                                      }
                                    }
                                    return Loader().center();
                                  });
                            } else {
                              return StreamBuilder<List<CrusadeModel>>(
                                  stream: crusadeDBService.crusadesWithoutArmy(snapshot.data!,crusadeApp.userId),
                                  builder: (context, snapshotArmiesCrusade) {
                                    if (snapshotArmiesCrusade.hasError) return Text(snapshotArmiesCrusade.error.toString()).center();
                                    if (snapshotArmiesCrusade.hasData) {
                                      if (snapshotArmiesCrusade.data!.isEmpty) {
                                        return noDataWidget(errorMessage: "No Crusades");
                                      } else {
                                        return ListView.builder(
                                          itemBuilder: (context, index) {
                                            return ChooseCrusadeItemComponent(crusade: snapshotArmiesCrusade.data![index]).onTap(() => {
                                              ChooseArmyNameScreen(fraction: widget.fraction.validate(), crusadeData: snapshotArmiesCrusade.data![index]).launch(context)
                                            });
                                          },
                                          padding: EdgeInsets.all(8),
                                          itemCount: snapshotArmiesCrusade.data!.length,
                                          physics: ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                        );
                                      }
                                    }
                                    return Loader().center();
                                  });
                            }
                          }
                          return Loader().center();
                        }
                      )
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
