// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CrusadeApp.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CrusadeApp on _CrusadeApp, Store {
  late final _$isLoggedInAtom =
      Atom(name: '_CrusadeApp.isLoggedIn', context: context);

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_CrusadeApp.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isNotificationOnAtom =
      Atom(name: '_CrusadeApp.isNotificationOn', context: context);

  @override
  bool get isNotificationOn {
    _$isNotificationOnAtom.reportRead();
    return super.isNotificationOn;
  }

  @override
  set isNotificationOn(bool value) {
    _$isNotificationOnAtom.reportWrite(value, super.isNotificationOn, () {
      super.isNotificationOn = value;
    });
  }

  late final _$isDarkModeAtom =
      Atom(name: '_CrusadeApp.isDarkMode', context: context);

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  late final _$isMasterAtom =
      Atom(name: '_CrusadeApp.isMaster', context: context);

  @override
  bool get isMaster {
    _$isMasterAtom.reportRead();
    return super.isMaster;
  }

  @override
  set isMaster(bool value) {
    _$isMasterAtom.reportWrite(value, super.isMaster, () {
      super.isMaster = value;
    });
  }

  late final _$appBarThemeAtom =
      Atom(name: '_CrusadeApp.appBarTheme', context: context);

  @override
  AppBarTheme get appBarTheme {
    _$appBarThemeAtom.reportRead();
    return super.appBarTheme;
  }

  @override
  set appBarTheme(AppBarTheme value) {
    _$appBarThemeAtom.reportWrite(value, super.appBarTheme, () {
      super.appBarTheme = value;
    });
  }

  late final _$userFullNameAtom =
      Atom(name: '_CrusadeApp.userFullName', context: context);

  @override
  String? get userFullName {
    _$userFullNameAtom.reportRead();
    return super.userFullName;
  }

  @override
  set userFullName(String? value) {
    _$userFullNameAtom.reportWrite(value, super.userFullName, () {
      super.userFullName = value;
    });
  }

  late final _$userEmailAtom =
      Atom(name: '_CrusadeApp.userEmail', context: context);

  @override
  String? get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String? value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  late final _$userIdAtom = Atom(name: '_CrusadeApp.userId', context: context);

  @override
  String? get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(String? value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  late final _$phoneNumberAtom =
      Atom(name: '_CrusadeApp.phoneNumber', context: context);

  @override
  String? get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String? value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  late final _$setLoggedInAsyncAction =
      AsyncAction('_CrusadeApp.setLoggedIn', context: context);

  @override
  Future<void> setLoggedIn(bool val) {
    return _$setLoggedInAsyncAction.run(() => super.setLoggedIn(val));
  }

  late final _$setUserIdAsyncAction =
      AsyncAction('_CrusadeApp.setUserId', context: context);

  @override
  Future<void> setUserId(String? val) {
    return _$setUserIdAsyncAction.run(() => super.setUserId(val));
  }

  late final _$setUserEmailAsyncAction =
      AsyncAction('_CrusadeApp.setUserEmail', context: context);

  @override
  Future<void> setUserEmail(String? val) {
    return _$setUserEmailAsyncAction.run(() => super.setUserEmail(val));
  }

  late final _$setFullNameAsyncAction =
      AsyncAction('_CrusadeApp.setFullName', context: context);

  @override
  Future<void> setFullName(String? val) {
    return _$setFullNameAsyncAction.run(() => super.setFullName(val));
  }

  late final _$setPhoneNumberAsyncAction =
      AsyncAction('_CrusadeApp.setPhoneNumber', context: context);

  @override
  Future<void> setPhoneNumber(String? val) {
    return _$setPhoneNumberAsyncAction.run(() => super.setPhoneNumber(val));
  }

  late final _$_CrusadeAppActionController =
      ActionController(name: '_CrusadeApp', context: context);

  @override
  void setLoading(bool val) {
    final _$actionInfo = _$_CrusadeAppActionController.startAction(
        name: '_CrusadeApp.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$_CrusadeAppActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNotification(bool val) {
    final _$actionInfo = _$_CrusadeAppActionController.startAction(
        name: '_CrusadeApp.setNotification');
    try {
      return super.setNotification(val);
    } finally {
      _$_CrusadeAppActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMaster(bool val) {
    final _$actionInfo = _$_CrusadeAppActionController.startAction(
        name: '_CrusadeApp.setMaster');
    try {
      return super.setMaster(val);
    } finally {
      _$_CrusadeAppActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn},
isLoading: ${isLoading},
isNotificationOn: ${isNotificationOn},
isDarkMode: ${isDarkMode},
isMaster: ${isMaster},
appBarTheme: ${appBarTheme},
userFullName: ${userFullName},
userEmail: ${userEmail},
userId: ${userId},
phoneNumber: ${phoneNumber}
    ''';
  }
}
