import 'package:my_crusade/utils/ModalKeys.dart';

class BattleModel {
  String? mission;
  String? attackerId;
  String? defenderId;
  String? winner;
  String? crusadeId;
  String? id;

  BattleModel({
    this.mission,
    this.attackerId,
    this.defenderId,
    this.winner,
    this.crusadeId,
    this.id
  });

  factory BattleModel.fromJson(Map<String, dynamic> json) {
    return BattleModel(
      mission: json[BattleKeys.mission],
      attackerId: json[BattleKeys.attackerId],
      defenderId: json[BattleKeys.defenderId],
      winner: json[BattleKeys.winner],
      crusadeId: json[BattleKeys.crusadeId],
      id: json[CommonKeys.id]
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[BattleKeys.mission] = this.mission;
    data[BattleKeys.attackerId] = this.attackerId;
    data[BattleKeys.defenderId] = this.defenderId;
    data[BattleKeys.winner] = this.winner;
    data[BattleKeys.crusadeId] = this.crusadeId;
    data[CommonKeys.id] = this.id;

    return data;
  }
}
