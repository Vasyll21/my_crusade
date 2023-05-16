import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_crusade/components/UserItemComponent.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/models/UserModel.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/ModalKeys.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

import 'CrusadeMenuScreen.dart';

class ChooseDefenderScreen extends StatefulWidget {
  static String tag = '/ChooseAttackerScreen';

  String? mission;
  CrusadeModel? crusadeData;
  UserModel? attacker;

  ChooseDefenderScreen({this.mission, this.crusadeData, this.attacker});

  @override
  ChooseDefenderScreenState createState() => ChooseDefenderScreenState();
}

class ChooseDefenderScreenState extends State<ChooseDefenderScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future createBattle(UserModel? defender) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      crusadeApp.setLoading(true);

      Map<String, dynamic> data = {
        BattleKeys.mission: widget.mission,
        BattleKeys.attackerId: widget.attacker!.uid,
        BattleKeys.defenderId: defender!.uid,
        BattleKeys.winner: null,
        BattleKeys.crusadeId: widget.crusadeData!.id
      };

      await battleDBService.addDocument(data).then((value) async{
      }).catchError((e) {
        toast(e.toString());
        log(e.toString());
      });
    }
    crusadeApp.setLoading(false);

    CrusadeMenuScreen(crusade: widget.crusadeData).launch(context);
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
        appBar: appBarWidget("Create Battle: Select defender", color: context.cardColor),
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
                      StreamBuilder<List<UserModel>>(
                          stream: userDBService.getInCrusadeUsers(widget.crusadeData!.participantsId!),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) return Text(snapshot.error.toString()).center();
                            if (snapshot.hasData) {
                              if (snapshot.data!.isEmpty) {
                                return noDataWidget(errorMessage: "No Users");
                              } else {
                                return ListView.builder(
                                  itemBuilder: (context, index) {
                                    return UserItemComponent(user: snapshot.data![index]).onTap(() async =>  {
                                      await createBattle(snapshot.data![index])
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
            ),
            Observer(builder: (_) => Loader().visible(crusadeApp.isLoading)),
          ],
        ),
      ),
    );
  }
}
