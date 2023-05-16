import 'package:flutter/material.dart';
import 'package:my_crusade/components/ArmyItemComponent.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/ArmyModel.dart';
import 'package:my_crusade/screens/CreateArmyScreen.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class ArmyFragment extends StatefulWidget {
  static String tag = '/ArmyFragment';

  @override
  ArmyFragmentState createState() => ArmyFragmentState();
}

class ArmyFragmentState extends State<ArmyFragment> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ArmyModel>>(
          stream: armyDBService.armiesByUser(crusadeApp.userId),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text(snapshot.error.toString()).center();
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return noDataWidget(errorMessage: "No Armies");
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ArmyItemComponent(army: snapshot.data![index]);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => CreateArmyScreen().launch(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
