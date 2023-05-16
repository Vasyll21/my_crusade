import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_crusade/components/CrusadeItemComponent.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/screens/ChooseArmyNameScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:my_crusade/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class ChooseCrusadeScreen extends StatefulWidget {
  static String tag = '/ChooseCrusadeScreen';

  String? fraction;

  ChooseCrusadeScreen({this.fraction});

  @override
  ChooseCrusadeScreenState createState() => ChooseCrusadeScreenState();
}

class ChooseCrusadeScreenState extends State<ChooseCrusadeScreen> {

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
        appBar: appBarWidget("Create Army: Select crusade", color: context.cardColor),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                    children: [
                      StreamBuilder<List<CrusadeModel>>(
                          stream: crusadeDBService.crusadesByUser(crusadeApp.userId),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) return Text(snapshot.error.toString()).center();
                            if (snapshot.hasData) {
                              if (snapshot.data!.isEmpty) {
                                return noDataWidget(errorMessage: "No Crusades");
                              } else {
                                return ListView.builder(
                                  itemBuilder: (context, index) {
                                    return CrusadeItemComponent(crusade: snapshot.data![index]).onTap(() => {
                                      ChooseArmyNameScreen(fraction: widget.fraction.validate(), crusadeData: snapshot.data![index]).launch(context)
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
            Observer(builder: (_) => Loader().visible(crusadeApp.isLoading)),
          ],
        ),
      ),
    );
  }
}
