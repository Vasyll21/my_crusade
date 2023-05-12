import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class ArmyFragment extends StatefulWidget {
  static String tag = '/ArmyFragment';

  @override
  ArmyFragmentState createState() => ArmyFragmentState();
}

class ArmyFragmentState extends State<ArmyFragment> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("In Progress"),
      ),
    );
  }
}
