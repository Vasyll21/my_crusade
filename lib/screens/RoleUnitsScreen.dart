import 'package:flutter/material.dart';
import 'package:my_crusade/components/UnitItemComponent.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/ArmyModel.dart';
import 'package:my_crusade/models/ArmyUnitModel.dart';
import 'package:my_crusade/screens/AddUnitScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class RoleUnitsScreen extends StatefulWidget {
  static String tag = '/RoleUnitsScreen';

  final String? role;
  final ArmyModel? army;

  RoleUnitsScreen({this.role, this.army});

  @override
  RoleUnitsScreenState createState() => RoleUnitsScreenState();
}

class RoleUnitsScreenState extends State<RoleUnitsScreen> {

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setStatusBarColor(
      crusadeApp.isDarkMode ? scaffoldColorDark : white,
      statusBarIconBrightness: crusadeApp.isDarkMode
          ? Brightness.light
          : Brightness.dark,
    );
  }

  @override
  void dispose() {
    setStatusBarColor(
      crusadeApp.isDarkMode ? scaffoldColorDark : white,
      statusBarIconBrightness: crusadeApp.isDarkMode
          ? Brightness.light
          : Brightness.dark,
    );
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: colorPrimary,
      backgroundColor: context.cardColor,
      onRefresh: () async {
        setState(() {});
        await 2.seconds.delay;
      },
      child: Scaffold(
        appBar: appBarWidget(
            '${widget.role.validate()} List',
            color: crusadeApp.isDarkMode ? scaffoldSecondaryDark : Colors.white,
            textColor: crusadeApp.isDarkMode ? Colors.white : Colors.black,
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => AddUnitScreen(role: widget.role.validate(), army: widget.army!).launch(context),
              ).visible(crusadeApp.isMaster),
            ]
        ),
        body: StreamBuilder<List<ArmyUnitModel>>(
            stream: armyUnitsDBService.unitsInArmyByRole(widget.army!.id!, widget.role!),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text(snapshot.error.toString()).center();
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return noDataWidget(errorMessage: "No Units");
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return UnitItemComponent(unit: snapshot.data![index]);
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