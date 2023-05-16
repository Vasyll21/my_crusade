import 'package:flutter/material.dart';
import 'package:my_crusade/models/ArmyUnitModel.dart';
import 'package:nb_utils/nb_utils.dart';

class UnitItemComponent extends StatefulWidget {
  final ArmyUnitModel? unit;

  UnitItemComponent({this.unit});

  @override
  UnitItemComponentState createState() => UnitItemComponentState();
}

class UnitItemComponentState extends State<UnitItemComponent> {

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
                title: Text(widget.unit!.unitName.validate()),
                subtitle: Text('cost: ${widget.unit!.pointCost}'),
              ),
            ],
          ).paddingAll(8),
        ],
      ),
    );
  }
}
