import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_crusade/components/UserItemComponent.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/models/UserModel.dart';
import 'package:my_crusade/screens/ChooseDefenderScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/ModalKeys.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class ChooseAttackerScreen extends StatefulWidget {
  static String tag = '/ChooseAttackerScreen';

  String? mission;
  CrusadeModel? crusadeData;

  ChooseAttackerScreen({this.mission, this.crusadeData});

  @override
  ChooseAttackerScreenState createState() => ChooseAttackerScreenState();
}

class ChooseAttackerScreenState extends State<ChooseAttackerScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
        appBar: appBarWidget("Create Battle: Select attacker", color: context.cardColor),
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
                                    return UserItemComponent(user: snapshot.data![index]).onTap(() => {
                                      ChooseDefenderScreen(crusadeData: widget.crusadeData, mission: widget.mission, attacker: snapshot.data![index]).launch(context)
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
