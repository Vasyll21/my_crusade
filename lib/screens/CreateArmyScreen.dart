import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_crusade/components/FactionComponent.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/screens/ChooseCrusadeScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateArmyScreen extends StatefulWidget {
  static String tag = '/CreateArmyScreen';

  CreateArmyScreen();

  @override
  CreateArmyScreenState createState() => CreateArmyScreenState();
}

class CreateArmyScreenState extends State<CreateArmyScreen> {

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
        appBar: appBarWidget("Create Army: Select fraction", color: context.cardColor),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FactionComponent(faction: "Astra Militarum").onTap(() => {
                      ChooseCrusadeScreen(fraction: "Astra Militarum").launch(context)
                    }),
                    FactionComponent(faction: "Necrons").onTap(() => {
                      ChooseCrusadeScreen(fraction: "Necrons").launch(context)
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
