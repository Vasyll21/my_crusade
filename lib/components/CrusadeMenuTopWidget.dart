import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class CrusadeMenuTopWidget extends StatefulWidget {
  static String tag = '/CrusadeMenuTopWidget';
  CrusadeModel? crusadeData;

  CrusadeMenuTopWidget({this.crusadeData});

  @override
  CrusadeMenuTopWidgetState createState() => CrusadeMenuTopWidgetState();
}

class CrusadeMenuTopWidgetState extends State<CrusadeMenuTopWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0, tileMode: TileMode.mirror),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(widget.crusadeData!.crusadeName.toString(), style: boldTextStyle(size: 18, color: Colors.white)).expand(),
                      ],
                    ).paddingOnly(left: 16, right: 16, top: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
