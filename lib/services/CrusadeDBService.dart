import 'package:my_crusade/models/CrusadeModel.dart';
import 'package:my_crusade/services/BaseService.dart';
import 'package:my_crusade/utils/Constants.dart';
import 'package:my_crusade/utils/ModalKeys.dart';

import '../main.dart';

class CrusadeDBService extends BaseService {
  CrusadeDBService() {
    ref = db.collection(CRUSADES);
  }

  Stream<List<CrusadeModel>> crusadesByUser(String? userId) {
    return ref
        .where(CrusadeKeys.participantsId, arrayContains: userId)
        .snapshots()
        .map((x) => x.docs.map((y) => CrusadeModel.fromJson(y.data() as Map<String, dynamic>)).toList());
  }

  Future<CrusadeModel> getCrusadeById(String? id) async {
    return await ref.where(CommonKeys.id, isEqualTo: id).get().then((value) {
      if (value.docs.isNotEmpty) {
        return CrusadeModel.fromJson(value.docs.first.data() as Map<String, dynamic>);
      } else {
        throw "No Crusade Found";
      }
    });
  }
}
