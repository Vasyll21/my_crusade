import 'package:my_crusade/utils/ModalKeys.dart';

class BattleModel {
  String? mission;
  String? attackerId;
  String? defenderId;
  String? winner;
  String? crusadeId;
  String? id;
  bool? hasWinner;

  BattleModel({
    this.mission,
    this.attackerId,
    this.defenderId,
    this.winner,
    this.crusadeId,
    this.id,
    this.hasWinner
  });

  factory BattleModel.fromJson(Map<String, dynamic> json) {
    return BattleModel(
      mission: json[BattleKeys.mission],
      attackerId: json[BattleKeys.attackerId],
      defenderId: json[BattleKeys.defenderId],
      winner: json[BattleKeys.winner],
      crusadeId: json[BattleKeys.crusadeId],
      id: json[CommonKeys.id],
      hasWinner: json[BattleKeys.hasWinner]
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
    data[BattleKeys.hasWinner] = this.hasWinner;

    return data;
  }
}
