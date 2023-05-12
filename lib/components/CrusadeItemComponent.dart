import 'package:flutter/material.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/screens/CrusadeMenuScreen.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:nb_utils/nb_utils.dart';

class CrusadeItemComponent extends StatefulWidget {
  final CrusadeModel? crusade;

  CrusadeItemComponent({this.crusade});

  @override
  CrusadeItemComponentState createState() => CrusadeItemComponentState();
}

class CrusadeItemComponentState extends State<CrusadeItemComponent> {

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
    ).onTap(() {
      hideKeyboard(context);
      CrusadeMenuScreen(crusade: widget.crusade).launch(context);
    }, highlightColor: crusadeApp.isDarkMode ? scaffoldColorDark : context.cardColor);
  }
}
