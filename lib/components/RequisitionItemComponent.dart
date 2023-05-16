import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class RequisitionItemComponent extends StatefulWidget {
  final String? reqName;
  final String? reqDesc;

  RequisitionItemComponent({this.reqName, this.reqDesc});

  @override
  RequisitionItemComponentState createState() => RequisitionItemComponentState();
}

class RequisitionItemComponentState extends State<RequisitionItemComponent> {

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await 2.microseconds.delay;
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
              ListTile(
                title: Text(widget.reqName.validate()),
                subtitle: Text(widget.reqDesc.validate()),
              ),
            ],
          ).paddingAll(8),
        ],
      ),
    );
  }
}
