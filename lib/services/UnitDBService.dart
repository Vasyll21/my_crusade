import 'package:my_crusade/models/UnitModel.dart';
import 'package:my_crusade/services/BaseService.dart';
import 'package:my_crusade/utils/Constants.dart';
import 'package:my_crusade/utils/ModalKeys.dart';

import '../main.dart';

class UnitDBService extends BaseService {
  UnitDBService() {
    ref = db.collection(UNITS);
  }

  Stream<List<UnitModel>> unitsInByRoleAndFraction(String fraction, String role) {
    return ref
        .where(ArmyUnitsKeys.fraction, isEqualTo: fraction)
        .where(ArmyUnitsKeys.role, isEqualTo: role)
        .snapshots()
        .map((x) => x.docs.map((y) => UnitModel.fromJson(y.data() as Map<String, dynamic>)).toList());
  }
}
