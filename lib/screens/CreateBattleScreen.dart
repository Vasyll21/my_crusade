import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_crusade/components/MissionItemComponent.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateBattleScreen extends StatefulWidget {
  static String tag = '/CreateBattleScreen';

  CrusadeModel? crusadeData;

  CreateBattleScreen({this.crusadeData});

  @override
  CreateBattleScreenState createState() => CreateBattleScreenState();
}

class CreateBattleScreenState extends State<CreateBattleScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<String> missions = <String>[
    "Sweep and Clear",
    "Supply Drop",
    "Assassinate"
  ];

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
        appBar: appBarWidget("Create Battle: Select mission", color: context.cardColor),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                    children: [
                      MissionItemComponent(
                        mission: missions[0],
                        crusadeData: widget.crusadeData
                      ),
                      MissionItemComponent(
                          mission: missions[1],
                          crusadeData: widget.crusadeData
                      ),
                      MissionItemComponent(
                          mission: missions[2],
                          crusadeData: widget.crusadeData
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