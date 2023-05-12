import 'package:my_crusade/models/BattleModel.dart';
import 'package:my_crusade/services/BaseService.dart';
import 'package:my_crusade/utils/Constants.dart';
import 'package:my_crusade/utils/ModalKeys.dart';

import '../main.dart';

class BattleDBService extends BaseService {
  BattleDBService() {
    ref = db.collection(BATTLES);
  }

  Stream<List<BattleModel>> battlesByCrusade(String? crusadeId) {
    return ref
        .where(BattleKeys.crusadeId, isEqualTo: crusadeId)
        .snapshots()
        .map((x) => x.docs.map((y) => BattleModel.fromJson(y.data() as Map<String, dynamic>)).toList());
  }
}
