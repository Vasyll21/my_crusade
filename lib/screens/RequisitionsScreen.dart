import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_crusade/components/RequisitionItemComponent.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/ArmyModel.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/screens/AddRelicScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:nb_utils/nb_utils.dart';

class RequisitionsScreen extends StatefulWidget {
  static String tag = '/RequisitionsScreen';

  ArmyModel? armyData;
  CrusadeModel? crusadeData;

  RequisitionsScreen({this.armyData, this.crusadeData});

  @override
  RequisitionsScreenState createState() => RequisitionsScreenState();
}

class RequisitionsScreenState extends State<RequisitionsScreen> {

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
  }

  Future addMaxPoints() async {
      ArmyModel army = widget.armyData!;

      if(army.reqPoints! >= 1){
        crusadeApp.setLoading(true);

        if(army.maxPoints == null){
          army.maxPoints = 5;
        } else{
          int max = army.maxPoints!;
          army.maxPoints = max + 5;
        }

        armyDBService.updateDocument(army.toJson(), army.id);

        crusadeApp.setLoading(false);
        finish(context);
      }
      else{
        final snackBar = SnackBar(
          content: Text("Not enough Requisitions Points"),
          duration: Duration(seconds: 30),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }


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
        appBar: appBarWidget('Requisitions List: Current value ${widget.armyData!.reqPoints}', color: context.cardColor),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RequisitionItemComponent(
                      reqDesc: "Increase your max points by 5",
                      reqName: "Increase supply limit"
                    ).onTap(() => {
                      addMaxPoints()
                    }),
                    RequisitionItemComponent(
                      reqName: "Relic",
                      reqDesc: "Add relic to your character",
                    ).onTap(() {
                      if(widget.armyData!.reqPoints! >= 1){
                        AddRelicScreen(army: widget.armyData, crusadeModel: widget.crusadeData!).launch(context);
                      }else {
                        final snackBar = SnackBar(
                          content: Text("Not enough Requisitions Points"),
                          duration: Duration(seconds: 30),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
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
