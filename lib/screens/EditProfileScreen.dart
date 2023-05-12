import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Common.dart';
import 'package:my_crusade/utils/Constants.dart';
import 'package:my_crusade/utils/ModalKeys.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class EditProfileScreen extends StatefulWidget {
  static String tag = '/EditProfileScreen';

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();

  FocusNode emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    fullNameController.text = crusadeApp.userFullName!;
  }

  Future save() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      hideKeyboard(context);
      crusadeApp.setLoading(true);
      setState(() {});

      Map<String, dynamic> req = {
        CommonKeys.updatedAt: DateTime.now(),
      };

      if (fullNameController.text != crusadeApp.userFullName) {
        req.putIfAbsent(UserKeys.name, () => fullNameController.text.trim());
      }

      await userDBService.updateDocument(req, crusadeApp.userId).then((value) async {
        crusadeApp.setLoading(false);
        crusadeApp.setFullName(fullNameController.text);
        setValue(USER_DISPLAY_NAME, fullNameController.text);

        finish(context);
      });
    }
  }
  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    Widget profileImage() {
      return Icon(Icons.person_outline_rounded).paddingAll(16);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: crusadeApp.isDarkMode ? scaffoldColorDark : Colors.white,
        appBar: appBarWidget("Edit Profile", color: context.cardColor),
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
                      Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 16,
                              margin: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                              child: profileImage(),
                            ),
                            Text(
                              "Change Profile",
                              style: boldTextStyle(),
                            ).paddingTop(16),
                            4.height,
                            Text(crusadeApp.userEmail.validate(), style: primaryTextStyle()),
                          ],
                        ).paddingOnly(top: 16, bottom: 16),
                      ).paddingTop(16),
                      16.height,
                      AppTextField(
                        controller: fullNameController,
                        textFieldType: TextFieldType.NAME,
                        decoration: inputDecoration(labelText: "Full Name"),
                        textStyle: isLoggedInWithApp() ? primaryTextStyle() : secondaryTextStyle(),
                        enabled: isLoggedInWithApp(),
                      ),
                      30.height,
                      AppButton(
                        text: "Save",
                        color: crusadeApp.isDarkMode ? scaffoldSecondaryDark : colorPrimary,
                        textStyle: boldTextStyle(color: white),
                        enabled: isLoggedInWithApp(),
                        onTap: () {
                          save();
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
