import 'package:flutter/material.dart';
import 'package:my_crusade/models/CrusadeModel.dart';

class ArmyTabComponent extends StatefulWidget {
  static String tag = '/ReviewTabComponent';
  CrusadeModel? crusadeData;

  ArmyTabComponent({this.crusadeData});

  @override
  ArmyTabComponentState createState() => ArmyTabComponentState();
}

class ArmyTabComponentState extends State<ArmyTabComponent> {

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text("In process")],
    );
  }
}
