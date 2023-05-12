import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/UserModel.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Common.dart';
import 'package:my_crusade/utils/ModalKeys.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateCrusadeScreen extends StatefulWidget {
  static String tag = '/CreateCrusadeScreen';

  @override
  CreateCrusadeScreenState createState() => CreateCrusadeScreenState();
}

class CreateCrusadeScreenState extends State<CreateCrusadeScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController crusadeNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future createCrusade() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      crusadeApp.setLoading(true);

      List<String> usersId = [];
      usersId.add(crusadeApp.userId.validate());

      Map<String, dynamic> data = {
        CrusadeKeys.crusadeName: crusadeNameController.text,
        CrusadeKeys.participantsId: usersId,
        CrusadeKeys.masterId: crusadeApp.userId
      };

      await crusadeDBService.addDocument(data).then((value) async{
        finish(context);
      }).catchError((e) {
        toast(e.toString());
        log(e.toString());
      });
    }

    crusadeApp.setLoading(false);
  }

  Future<void> init() async {
    crusadeNameController.text = "";
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
                        controller: crusadeNameController,
                        textFieldType: TextFieldType.NAME,
                        decoration: inputDecoration(labelText: "Crusade Name"),
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
