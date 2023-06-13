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
                      StreamBuilder<List<CrusadeModel>>(
                        stream: crusadeDBService.crusadesByUser(crusadeApp.userId),
                        builder: (context, snapshotCrusades) {
                          if (snapshotCrusades.hasError) return Text(snapshotCrusades.error.toString()).center();
                          if (snapshotCrusades.hasData) {
                            if (snapshotCrusades.data!.isEmpty) {
                              return noDataWidget(errorMessage: "No Crusades");
                            } else {
                              return ListView.builder(
                                itemBuilder: (context, index1) {
                                  return ChooseCrusadeItemComponent(crusade: snapshotCrusades.data![index1]).onTap(() => {
                                    ChooseArmyNameScreen(fraction: widget.fraction.validate(), crusadeData: snapshotCrusades.data![index1]).launch(context)
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
                        })
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
