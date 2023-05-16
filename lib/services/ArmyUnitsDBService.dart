import 'package:my_crusade/models/ArmyUnitModel.dart';
import 'package:my_crusade/services/BaseService.dart';
import 'package:my_crusade/utils/Constants.dart';
import 'package:my_crusade/utils/ModalKeys.dart';

import '../main.dart';

class ArmyUnitsDBService extends BaseService {
  ArmyUnitsDBService() {
    ref = db.collection(ARMYUNITS);
  }

  Stream<List<ArmyUnitModel>> unitsInArmyByRole(String? armyId, String? role) {
    return ref
        .where(ArmyUnitsKeys.armyId, isEqualTo: armyId)
        .where(ArmyUnitsKeys.role, isEqualTo: role)
        .snapshots()
        .map((x) => x.docs.map((y) => ArmyUnitModel.fromJson(y.data() as Map<String, dynamic>)).toList());
  }

  Stream<List<ArmyUnitModel>> characterUnitsInArmy(String? armyId, bool isCharacter) {
    return ref
        .where(ArmyUnitsKeys.armyId, isEqualTo: armyId)
        .where(ArmyUnitsKeys.isCharacter, isEqualTo: isCharacter)
        .snapshots()
        .map((x) => x.docs.map((y) => ArmyUnitModel.fromJson(y.data() as Map<String, dynamic>)).toList());
  }

  Future<ArmyUnitModel> getArmyUnitById(String? id) async {
    return await ref.where(CommonKeys.id, isEqualTo: id).get().then((value) {
      if (value.docs.isNotEmpty) {
        return ArmyUnitModel.fromJson(value.docs.first.data() as Map<String, dynamic>);
      } else {
        throw "No User Found";
      }
    });
  }
}
