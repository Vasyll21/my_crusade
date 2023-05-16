import 'package:my_crusade/utils/ModalKeys.dart';

class ArmyUnitModel {
  String? unitName;
  String? armyId;
  String? role;
  String? fraction;
  int? pointCost;
  bool? isCharacter;
  String? id;

  ArmyUnitModel({
    this.unitName,
    this.armyId,
    this.role,
    this.fraction,
    this.pointCost,
    this.isCharacter,
    this.id
  });

  factory ArmyUnitModel.fromJson(Map<String, dynamic> json) {
    return ArmyUnitModel(
        unitName: json[ArmyUnitsKeys.unitName],
        armyId: json[ArmyUnitsKeys.armyId],
        role: json[ArmyUnitsKeys.role],
        fraction: json[ArmyUnitsKeys.fraction],
        pointCost: json[ArmyUnitsKeys.pointCost],
        isCharacter: json[ArmyUnitsKeys.isCharacter],
        id: json[CommonKeys.id]
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[ArmyUnitsKeys.unitName] = this.unitName;
    data[ArmyUnitsKeys.armyId] = this.armyId;
    data[ArmyUnitsKeys.role] = this.role;
    data[ArmyUnitsKeys.fraction] = this.fraction;
    data[ArmyUnitsKeys.pointCost] = this.pointCost;
    data[ArmyUnitsKeys.isCharacter] = this.isCharacter;
    data[CommonKeys.id] = this.id;

    return data;
  }
}
