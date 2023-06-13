import 'package:flutter/material.dart';
import 'package:my_crusade/components/UserItemComponent.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/models/UserModel.dart';
import 'package:my_crusade/screens/AddUserScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class ParticipantsScreen extends StatefulWidget {
  static String tag = '/ParticipantsScreen';

  List<String>? usersId;
  CrusadeModel? crusadeData;

  ParticipantsScreen({this.usersId, this.crusadeData});

  @override
  ParticipantsScreenState createState() => ParticipantsScreenState();
}

class ParticipantsScreenState extends State<ParticipantsScreen> {

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
          "Users List",
          color: crusadeApp.isDarkMode ? scaffoldSecondaryDark : Colors.white,
          textColor: crusadeApp.isDarkMode ? Colors.white : Colors.black,
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => AddUserScreen(crusadeData: widget.crusadeData).launch(context),
              ).visible(crusadeApp.userId == widget.crusadeData!.masterId),
            ]
        ),
        body: StreamBuilder<List<UserModel>>(
            stream: userDBService.getInCrusadeUsers(widget.crusadeData!.participantsId!),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text(snapshot.error.toString()).center();
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return noDataWidget(errorMessage: "No Users");
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return UserItemComponent(user: snapshot.data![index]);
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