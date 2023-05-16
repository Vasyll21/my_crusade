import 'package:flutter/material.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/screens/CrusadeMenuScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:nb_utils/nb_utils.dart';

class ChooseCrusadeItemComponent extends StatefulWidget {
  final CrusadeModel? crusade;

  ChooseCrusadeItemComponent({this.crusade});

  @override
  ChooseCrusadeItemComponentState createState() => ChooseCrusadeItemComponentState();
}

class ChooseCrusadeItemComponentState extends State<ChooseCrusadeItemComponent> {

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await 1.microseconds.delay;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: context.width(),
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: context.scaffoldBackgroundColor,
        boxShadow: defaultBoxShadow(spreadRadius: 0.0, blurRadius: 0.0),
        border: Border.all(color: context.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.crusade!.crusadeName.validate(), style: boldTextStyle(size: 20)),
            ],
          ).paddingAll(8),
        ],
      ),
    );
  }
}
