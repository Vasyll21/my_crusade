import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_crusade/main.dart';
import 'package:my_crusade/models/UserModel.dart';
import 'package:my_crusade/utils/Constants.dart';
import 'package:my_crusade/utils/ModalKeys.dart';
import 'package:nb_utils/nb_utils.dart';

Future<User?> _signInWithEmail(String email, String password) async {
  return await auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
    return value.user;
  }).catchError((e) {
    throw e;
  });
}

Future<void> signUpWithEmail(String name, String email, String password, String phone) async {
  UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);

  if (userCredential.user != null) {
    User currentUser = userCredential.user!;
    UserModel userModel = UserModel();

    /// Create user
    userModel.uid = currentUser.uid.validate();
    userModel.email = currentUser.email.validate();
    userModel.password = password.validate();
    userModel.name = name.validate();
    userModel.number = phone.validate();
    userModel.loginType = LoginTypeApp;
    userModel.updatedAt = DateTime.now();
    userModel.createdAt = DateTime.now();
    userModel.isMaster = false;
    userModel.isDeleted = false;

    userModel.oneSignalPlayerId = getStringAsync(PLAYER_ID);

    await userDBService.addDocumentWithCustomId(currentUser.uid, userModel.toJson()).then((value) async {
      await signInWithEmail(email: email, password: password).then((value) {
        //
      });
    }).catchError((e) {
      throw e;
    });
  } else {
    throw errorSomethingWentWrong;
  }
}

Future<UserModel> signInWithEmail({String? email, String? password}) async {
  if (await userDBService.isUserExist(email, LoginTypeApp)) {
    return await _signInWithEmail(email!, password!).then((user) async {
      return await userDBService.loginWithEmail(email: user!.email, password: password).then((value) async {
        await saveUserDetails(value, LoginTypeApp);
        return value;
      }).catchError((e) {
        throw e;
      });
    });
  } else {
    throw "You are not registered";
  }
}

Future<void> saveUserDetails(UserModel userModel, String loginType) async {
  await setValue(LOGIN_TYPE, loginType);

  await setValue(MASTER, userModel.isMaster.validate());

  await crusadeApp.setLoggedIn(true);
  await crusadeApp.setUserId(userModel.uid);
  await crusadeApp.setFullName(userModel.name);
  await crusadeApp.setUserEmail(userModel.email);
  await crusadeApp.setPhoneNumber(userModel.number);

  /// Update user data
  userDBService.updateDocument({
    UserKeys.oneSignalPlayerId: getStringAsync(PLAYER_ID).validate(),
    CommonKeys.updatedAt: DateTime.now(),
  }, userModel.uid);
}

Future<void> logout() async {
  userDBService.updateDocument({
    UserKeys.oneSignalPlayerId: '',
    CommonKeys.updatedAt: DateTime.now(),
  }, crusadeApp.userId).then((value) async {
    //
  }).catchError((e) {
    throw e;
  });
  await removeKey(IS_NOTIFICATION_ON);
  await removeKey(USER_ROLE);

  crusadeApp.setLoggedIn(false);
  crusadeApp.setUserId('');
  crusadeApp.setFullName('');
  crusadeApp.setUserEmail('');
}
