import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:socio/model/user/user.dart';
import 'package:socio/util/service_locator.dart';
import 'package:socio/util/shared_preference_handler.dart';

import '../bloc/session_bloc.dart';
import '../constant/shared_preference_constants.dart';
import '../ui/home_tab/bloc/home_tab_bloc.dart';

class UserDataHelper {

  ValueNotifier<UserAccount>? _userAccountNotifier;

  ValueNotifier<UserAccount>? get userAccountNotifier{
    return _userAccountNotifier;
  }

  SharedPreferencesHandler? get _sharedPreferences => SharedPreferencesHandler.instance;

  Future<void> initialize() async{
    _getUserDetailsFromLocalIfExists();
  }

  Future<void> setUserDetailsFromServer(Map<String, dynamic> data) async {
    UserAccount account = _setInMemoryUserAccountInfo(data);
    await _setInMemoryUserAccountObjectIntoDatabase(account);
  }

  Future<void> _setInMemoryUserAccountObjectIntoDatabase(UserAccount account) async {
    await _sharedPreferences!.setString(
      SharedPrefConstants.USER_INFO,
      jsonEncode(account),
    );
  }

  UserAccount _setInMemoryUserAccountInfo(Map<String, dynamic> data) {
    UserAccount account = UserAccount.fromJson(data);
    _setInMemoryUserAccountObject(account);
    return account;
  }

  Future<void> _getUserDetailsFromLocalIfExists() async {
    String? userInfoString = await _sharedPreferences!.getString(SharedPrefConstants.USER_INFO);
    if (userInfoString != null) {
      _setInMemoryUserAccountInfo(jsonDecode(userInfoString)
      as Map<String,dynamic>);
    }
  }

  Future<void> _setInMemoryUserAccountObject(UserAccount account) async {
    if (_userAccountNotifier == null) {
      _userAccountNotifier = ValueNotifier(account);
    } else {
      userAccountNotifier!.value = account;
    }
  }

  Future _clearAllData() async {
    try {
      _deallocateAllSingletons();
    } catch (e) {
      debugPrint('Clear data error');
    }
  }

  Future<void> signOutUser() async {
    await _logoutUser();
    await _clearAllData();
  }

  Future<void> _logoutUser() async {
    try {
      await SessionBloc.removeUserId();
      await SessionBloc.removeRefreshToken();
      await SessionBloc.removeAuthDetails();
      await SessionBloc.removeSessionId();
      await SessionBloc.removeUsername();
      _sharedPreferences!.setBool(SharedPrefConstants.IS_LOGGED_IN, false);
      _sharedPreferences!.remove(SharedPrefConstants.USER_INFO);
    } catch (e) {
      debugPrint('Failed To Logout User: ${e.toString()}');
    }
  }

  void expireUserSession() {
    _deallocateAllSingletons();
  }

  static String? getUserId() {
    UserDataHelper userDataBloc = injector<UserDataHelper>();
    String? userId = userDataBloc.userAccountNotifier!.value.uid;
    return userId;
  }

  static String? getUserName() {
    UserDataHelper userDataBloc = injector<UserDataHelper>();
    String? userName = userDataBloc.userAccountNotifier!.value.firstName;
    return userName;
  }


  void _deallocateAllSingletons() {
    HomeTabBloc.instance.dispose();
  }
}

