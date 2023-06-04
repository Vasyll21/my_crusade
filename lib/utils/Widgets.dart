import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_crusade/utils/Colors.dart';
import 'package:nb_utils/nb_utils.dart';

InputDecoration inputDecoration({String? labelText}) {
  return InputDecoration(
    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: radius() as BorderRadius),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: radius() as BorderRadius),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: colorPrimary), borderRadius: radius() as BorderRadius),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: radius() as BorderRadius),
    focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: radius() as BorderRadius),
    labelText: labelText,
    labelStyle: primaryTextStyle(),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    alignLabelWithHint: true,
  );
}

InputDecoration labelInputDecoration({String? labelText}) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4)), borderSide: BorderSide(width: 1, color: colorPrimary)),
    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4)), borderSide: BorderSide(width: 1, color: colorPrimary)),
    errorStyle: TextStyle(color: colorPrimary.withOpacity(0.5)),
    labelStyle: TextStyle(color: colorPrimary.withOpacity(0.5)),
    labelText: labelText,
  );
}

Widget noDataWidget({String? errorMessage}) {
  return Container(alignment: Alignment.center, child: Text(errorMessage.validate(value: "No Data Found"), style: boldTextStyle()).center());
}