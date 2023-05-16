import 'package:my_crusade/utils/ModalKeys.dart';

class ArmyModel {
  String? armyName;
  String? userId;
  String? crusadeId;
  String? fraction;
  int? maxPoints;
  int? currentPoints;
  int? reqPoints;
  String? id;

  ArmyModel({
    this.armyName,
    this.userId,
    this.crusadeId,
    this.fraction,
    this.maxPoints,
    this.currentPoints,
    this.reqPoints,
    this.id
  });

  factory ArmyModel.fromJson(Map<String, dynamic> json) {
    return ArmyModel(
        armyName: json[ArmyKeys.armyName],
        userId: json[ArmyKeys.userId],
        crusadeId: json[ArmyKeys.crusadeId],
        fraction: json[ArmyKeys.fraction],
        maxPoints: json[ArmyKeys.maxPoints],
        currentPoints: json[ArmyKeys.currentPoints],
        reqPoints: json[ArmyKeys.reqPoints],
        id: json[CommonKeys.id]
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[ArmyKeys.armyName] = this.armyName;
    data[ArmyKeys.userId] = this.userId;
    data[ArmyKeys.crusadeId] = this.crusadeId;
    data[ArmyKeys.fraction] = this.fraction;
    data[ArmyKeys.maxPoints] = this.maxPoints;
    data[ArmyKeys.currentPoints] = this.currentPoints;
    data[ArmyKeys.reqPoints] = this.reqPoints;
    data[CommonKeys.id] = this.id;

    return data;
  }
}
