import 'package:my_crusade/models/ArmyModel.dart';
import 'package:my_crusade/services/BaseService.dart';
import 'package:my_crusade/utils/Constants.dart';
import 'package:my_crusade/utils/ModalKeys.dart';

import '../main.dart';

class ArmyDBService extends BaseService {
  ArmyDBService() {
    ref = db.collection(ARMIES);
  }

  Stream<List<ArmyModel>> armiesByUser(String? userId) {
    return ref
        .where(ArmyKeys.userId, isEqualTo: userId)
        .snapshots()
        .map((x) => x.docs.map((y) => ArmyModel.fromJson(y.data() as Map<String, dynamic>)).toList());
  }

  Future<ArmyModel> getUserArmyInCrusade(String? userId, String? crusadeId) async {
    return await ref.where(ArmyKeys.userId, isEqualTo: userId).where(ArmyKeys.crusadeId, isEqualTo: crusadeId).get().then((value) {
      if (value.docs.isNotEmpty) {
        return ArmyModel.fromJson(value.docs.first.data() as Map<String, dynamic>);
      } else {
        throw "No Army Found";
      }
    });
  }
}
