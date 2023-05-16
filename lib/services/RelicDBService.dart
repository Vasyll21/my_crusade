import 'package:my_crusade/models/RelicModel.dart';
import 'package:my_crusade/services/BaseService.dart';
import 'package:my_crusade/utils/Constants.dart';
import 'package:my_crusade/utils/ModalKeys.dart';

import '../main.dart';

class RelicDBService extends BaseService {
  RelicDBService() {
    ref = db.collection(RELICS);
  }

  Stream<List<RelicModel>> relicsByArmy(String? armyId) {
    return ref
        .where(RelicKeys.armyId, isEqualTo: armyId)
        .snapshots()
        .map((x) => x.docs.map((y) => RelicModel.fromJson(y.data() as Map<String, dynamic>)).toList());
  }


}
