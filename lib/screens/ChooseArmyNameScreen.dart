import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/ArmyModel.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/screens/ArmyScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Common.dart';
import 'package:my_crusade/utils/ModalKeys.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class ChooseArmyNameScreen extends StatefulWidget {
  static String tag = '/ChooseArmyNameScreen';

  String? fraction;
  CrusadeModel? crusadeData;

  ChooseArmyNameScreen({this.fraction, this.crusadeData});

  @override
  ChooseArmyNameScreenState createState() => ChooseArmyNameScreenState();
}

class ChooseArmyNameScreenState extends State<ChooseArmyNameScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController armyNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future createCrusade() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      crusadeApp.setLoading(true);

      Map<String, dynamic> data = {
        ArmyKeys.armyName: armyNameController.text,
        ArmyKeys.userId: crusadeApp.userId,
        ArmyKeys.crusadeId: widget.crusadeData!.id,
        ArmyKeys.fraction: widget.fraction.validate(),
        ArmyKeys.maxPoints: 50,
        ArmyKeys.currentPoints: 0,
        ArmyKeys.reqPoints: 5
      };

      await armyDBService.addDocument(data).then((value) async{
      }).catchError((e) {
        toast(e.toString());
        log(e.toString());
      });

      ArmyModel army = await armyDBService.getUserArmyInCrusade(crusadeApp.userId, widget.crusadeData!.id);
      ArmyScreen(crusadeData: widget.crusadeData!, armyData: army).launch(context);
    }

    crusadeApp.setLoading(false);
  }

  Future<void> init() async {
    armyNameController.text = "";
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
        appBar: appBarWidget("Create Crusade", color: context.cardColor),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: armyNameController,
                        textFieldType: TextFieldType.NAME,
                        decoration: inputDecoration(labelText: "Army Name"),
                        textStyle: isLoggedInWithApp() ? primaryTextStyle() : secondaryTextStyle(),
                        enabled: isLoggedInWithApp(),
                      ),
                      30.height,
                      AppButton(
                        text: "Create",
                        color: crusadeApp.isDarkMode ? scaffoldSecondaryDark : colorPrimary,
                        textStyle: boldTextStyle(color: white),
                        enabled: isLoggedInWithApp(),
                        onTap: () {
                          createCrusade();
                        },
                        width: context.width(),
                      ).visible(isLoggedInWithApp()),
                    ],
                  ),
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
