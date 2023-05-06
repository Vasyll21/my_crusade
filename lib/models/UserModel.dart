import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_crusade/utils/ModalKeys.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  String? number;
  String? password;
  String? loginType;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isMaster;
  bool? isDeleted;
  String? oneSignalPlayerId;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    this.number,
    this.password,
    this.loginType,
    this.createdAt,
    this.updatedAt,
    this.isMaster,
    this.isDeleted,
    this.oneSignalPlayerId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json[UserKeys.uid],
      name: json[UserKeys.name],
      email: json[UserKeys.email],
      photoUrl: json[UserKeys.photoUrl],
      isMaster: json[UserKeys.isMaster],
      number: json[UserKeys.number],
      password: json[UserKeys.password],
      loginType: json[UserKeys.loginType],
      createdAt: json[CommonKeys.createdAt] != null ? (json[CommonKeys.createdAt] as Timestamp).toDate() : null,
      updatedAt: json[CommonKeys.updatedAt] != null ? (json[CommonKeys.updatedAt] as Timestamp).toDate() : null,
      isDeleted: json[CommonKeys.isDeleted],
      oneSignalPlayerId: json[UserKeys.oneSignalPlayerId],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[UserKeys.uid] = this.uid;
    data[UserKeys.name] = this.name;
    data[UserKeys.email] = this.email;
    data[UserKeys.photoUrl] = this.photoUrl;
    data[UserKeys.loginType] = this.loginType;
    data[CommonKeys.createdAt] = this.createdAt;
    data[CommonKeys.updatedAt] = this.updatedAt;
    data[UserKeys.isMaster] = this.isMaster;
    data[UserKeys.number] = this.number;
    data[UserKeys.password] = this.password;
    data[CommonKeys.isDeleted] = this.isDeleted;
    data[UserKeys.oneSignalPlayerId] = this.oneSignalPlayerId;

    return data;
  }
}
