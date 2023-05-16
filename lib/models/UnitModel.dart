import 'package:my_crusade/utils/ModalKeys.dart';

class UnitModel {
  String? unitName;
  String? role;
  String? fraction;
  int? pointCost;
  bool? isCharacter;
  String? id;

  UnitModel({
    this.unitName,
    this.role,
    this.fraction,
    this.pointCost,
    this.isCharacter,
    this.id
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
        unitName: json[ArmyUnitsKeys.unitName],
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
    data[ArmyUnitsKeys.role] = this.role;
    data[ArmyUnitsKeys.fraction] = this.fraction;
    data[ArmyUnitsKeys.pointCost] = this.pointCost;
    data[ArmyUnitsKeys.isCharacter] = this.isCharacter;
    data[CommonKeys.id] = this.id;

    return data;
  }
}
