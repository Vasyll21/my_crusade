import 'package:my_crusade/utils/ModalKeys.dart';

class CrusadeModel {
  String? id;
  String? crusadeName;
  List<String>? participantsId;
  String? masterId;

  CrusadeModel({
    this.id,
    this.crusadeName,
    this.participantsId,
    this.masterId,
  });

  factory CrusadeModel.fromJson(Map<String, dynamic> json) {
    return CrusadeModel(
      id: json[CommonKeys.id],
      crusadeName: json[CrusadeKeys.crusadeName],
      participantsId: json[CrusadeKeys.participantsId] != null ? List<String>.from(json[CrusadeKeys.participantsId]) : [],
      masterId: json[CrusadeKeys.masterId],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[CommonKeys.id] = this.id;
    data[CrusadeKeys.crusadeName] = this.crusadeName;
    data[CrusadeKeys.participantsId] = this.participantsId;
    data[CrusadeKeys.masterId] = this.masterId;

    return data;
  }
}
