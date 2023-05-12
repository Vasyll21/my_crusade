import 'package:flutter/material.dart';
import 'package:my_crusade/models/UserModel.dart';
import 'package:nb_utils/nb_utils.dart';

class UserItemComponent extends StatefulWidget {
  final UserModel? user;

  UserItemComponent({this.user});

  @override
  UserItemComponentState createState() => UserItemComponentState();
}

class UserItemComponentState extends State<UserItemComponent> {

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
              Text(widget.user!.name.validate(), style: boldTextStyle(size: 20)),
            ],
          ).paddingAll(8),
        ],
      ),
    );
  }
}
