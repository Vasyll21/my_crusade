import 'package:my_crusade/utils/ModalKeys.dart';

class RelicModel {
  String? unitId;
  String? armyId;
  String? relicName;
  String? relicDesc;
  String? id;

  RelicModel({
    this.unitId,
    this.armyId,
    this.relicName,
    this.relicDesc,
    this.id
  });

  factory RelicModel.fromJson(Map<String, dynamic> json) {
    return RelicModel(
        unitId: json[RelicKeys.unitId],
        armyId: json[RelicKeys.armyId],
        relicName: json[RelicKeys.relicName],
        relicDesc: json[RelicKeys.relicDesc],
        id: json[CommonKeys.id]
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[RelicKeys.unitId] = this.unitId;
    data[RelicKeys.armyId] = this.armyId;
    data[RelicKeys.relicName] = this.relicName;
    data[RelicKeys.relicDesc] = this.relicDesc;
    data[CommonKeys.id] = this.id;

    return data;
  }
}
