import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_crusade/components/CrusadeMenuTopWidget.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:nb_utils/nb_utils.dart';
import '../components/ArmyTabComponent.dart';
import '../components/CrusadeMenuTabWidget.dart';
import '../main.dart';

// ignore: must_be_immutable
class CrusadeMenuScreen extends StatefulWidget {
  static String tag = '/CrusadeMenuScreen';

  CrusadeModel? crusade;

  CrusadeMenuScreen({this.crusade});

  @override
  CrusadeMenuScreenState createState() => CrusadeMenuScreenState();
}

class CrusadeMenuScreenState extends State<CrusadeMenuScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    _tabController = TabController(length: 2, vsync: this);

    setStatusBarColor(crusadeApp.isDarkMode ? scaffoldColorDark : colorPrimary, statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    setStatusBarColor(crusadeApp.isDarkMode ? scaffoldColorDark : Colors.white);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: splashBgColor,
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    controller: _tabController,
                    labelStyle: boldTextStyle(),
                    unselectedLabelStyle: primaryTextStyle(),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: EdgeInsets.all(8),
                    indicatorColor: colorPrimary,
                    unselectedLabelColor: grey,
                    tabs: <Widget>[
                      Text("Menu"),
                      Text("My Army"),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                CrusadeMenuTabWidget(crusadeData: widget.crusade),
                ArmyTabComponent(crusadeData: widget.crusade),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
