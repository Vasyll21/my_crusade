import 'package:flutter/material.dart';
import 'package:my_crusade/components/UserItemComponent.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/models/UserModel.dart';
import 'package:my_crusade/screens/ParticipantsScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class AddUserScreen extends StatefulWidget {
  static String tag = '/AddUserScreen';

  CrusadeModel? crusadeData;

  AddUserScreen({this.crusadeData});

  @override
  AddUserScreenState createState() => AddUserScreenState();
}

class AddUserScreenState extends State<AddUserScreen> {

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

  Future addUser(String? userId) async {
    crusadeApp.setLoading(true);
    widget.crusadeData!.participantsId!.add(userId.validate());

    await crusadeDBService.updateDocument(widget.crusadeData!.toJson(), widget.crusadeData!.id).then((value) => ()
    {
      finish(context);
    });

    crusadeApp.setLoading(false);
    ParticipantsScreen(crusadeData: widget.crusadeData!,usersId: widget.crusadeData!.participantsId);
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
            "Add User",
            color: crusadeApp.isDarkMode ? scaffoldSecondaryDark : Colors.white,
            textColor: crusadeApp.isDarkMode ? Colors.white : Colors.black,
        ),
        body: StreamBuilder<List<UserModel>>(
            stream: userDBService.getNotInCrusadeUsers(widget.crusadeData!.participantsId!),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text(snapshot.error.toString()).center();
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return noDataWidget(errorMessage: "No Users to Add");
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return UserItemComponent(user: snapshot.data![index]).onTap(() {
                        addUser(snapshot.data![index].uid);
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
      ),
    );
  }
}