import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/UserModel.dart';
import 'package:my_crusade/services/BaseService.dart';
import 'package:my_crusade/utils/Constants.dart';
import 'package:my_crusade/utils/ModalKeys.dart';

class UserDBService extends BaseService {
  UserDBService() {
    ref = db.collection(USERS);
  }

  Future<UserModel> getUserById(String? id) async {
    return await ref.where(UserKeys.uid, isEqualTo: id).get().then((value) {
      if (value.docs.isNotEmpty) {
        return UserModel.fromJson(value.docs.first.data() as Map<String, dynamic>);
      } else {
        throw "No User Found";
      }
    });
  }

  Future<List<UserModel>> usersFuture() async {
    return await ref.orderBy(CommonKeys.updatedAt, descending: true).get().then((x) => x.docs.map((y) => UserModel.fromJson(y.data() as Map<String, dynamic>)).toList());
  }

  Stream<List<UserModel>> getNotInCrusadeUsers(List<String?> usersId) {
    return ref.where("uid", whereNotIn: usersId).snapshots()
        .map((x) => x.docs.map((y) => UserModel.fromJson(y.data() as Map<String, dynamic>)).toList());
  }

  Stream<List<UserModel>> getInCrusadeUsers(List<String?> usersId) {
    return ref.where("uid", whereIn: usersId).snapshots()
        .map((x) => x.docs.map((y) => UserModel.fromJson(y.data() as Map<String, dynamic>)).toList());
  }

  Future<bool> isUserExist(String? email, String loginType) async {
    Query query = ref.where(UserKeys.loginType, isEqualTo: loginType).where(UserKeys.email, isEqualTo: email);

    var res = await query.limit(1).get();

    if (res.docs.isNotEmpty) {
      return res.docs.length == 1;
    } else {
      return false;
    }
  }

  Future<UserModel> loginWithEmail({String? email, String? password}) async {
    return await ref.where(UserKeys.email, isEqualTo: email).limit(1).get().then((value) {
      if (value.docs.isNotEmpty) {
        UserModel user = UserModel.fromJson(value.docs.first.data() as Map<String, dynamic>);
        if (!user.isDeleted!) {
          return user;
        } else {
          throw "User deleted";
        }
      } else {
        throw "No User Found";
      }
    });
  }

  Future<UserModel> getUserByEmail(String? email) async {
    return await ref.where(UserKeys.email, isEqualTo: email).limit(1).get().then((value) {
      if (value.docs.isNotEmpty) {
        UserModel user = UserModel.fromJson(value.docs.first.data() as Map<String, dynamic>);
        if (!user.isDeleted!) {
          return user;
        } else {
          throw "User deleted";
        }
      } else {
        throw "No User Found";
      }
    });
  }
}
