import 'package:flutter/material.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/models/UserModel.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Constants.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/CrusadeItemComponent.dart';
import 'CreateCrusadeScreen.dart';

class CrusadesFragment extends StatefulWidget {
  static String tag = '/CrusadesFragment';

  @override
  CrusadesFragmentState createState() => CrusadesFragmentState();
}

class CrusadesFragmentState extends State<CrusadesFragment> {

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setStatusBarColor(
      crusadeApp.isDarkMode ? scaffoldColorDark : white,
      statusBarIconBrightness: crusadeApp.isDarkMode ? Brightness.light : Brightness.dark,
    );
  }

  @override
  void dispose() {
    setStatusBarColor(
      crusadeApp.isDarkMode ? scaffoldColorDark : white,
      statusBarIconBrightness: crusadeApp.isDarkMode ? Brightness.light : Brightness.dark,
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
          "Crusade List",
          color: crusadeApp.isDarkMode ? scaffoldSecondaryDark : Colors.white,
          textColor: crusadeApp.isDarkMode ? Colors.white : Colors.black,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => CreateCrusadeScreen().launch(context),
            ).visible(crusadeApp.isMaster),
          ]
        ),
        body: StreamBuilder<List<CrusadeModel>>(
            stream: crusadeDBService.crusadesByUser(crusadeApp.userId),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text(snapshot.error.toString()).center();
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return noDataWidget(errorMessage: "No Crusades");
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return CrusadeItemComponent(crusade: snapshot.data![index]);
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
