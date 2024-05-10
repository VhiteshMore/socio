
import '../constant/shared_preference_constants.dart';
import '../util/shared_preference_handler.dart';

class SessionBloc {

  static Future<void> setAuthDetails(String authToken) async {
    await SharedPreferencesHandler.instance!.setString(SharedPrefConstants.ACCESS_TOKEN, authToken);
  }

  static Future<void> setSessionId(String authToken) async {
    await SharedPreferencesHandler.instance!.setString(SharedPrefConstants.SESSION_ID, authToken);
  }

  static Future<String?> getSessionId() {
    return SharedPreferencesHandler.instance!.getString(SharedPrefConstants.SESSION_ID);
  }

  static Future<void> removeSessionId() async {
    await SharedPreferencesHandler.instance!.remove(SharedPrefConstants.SESSION_ID);
  }

  static Future<void> setRefreshToken(String refreshToken) async {
    await SharedPreferencesHandler.instance!.setString(SharedPrefConstants.REFRESH_TOKEN, refreshToken);
  }

  static Future<String?> getRefreshToken() {
    return SharedPreferencesHandler.instance!.getString(SharedPrefConstants.REFRESH_TOKEN);
  }

  static Future<void> setUserId(String userId) async {
    await SharedPreferencesHandler.instance!.setString(SharedPrefConstants.USER_ID, userId);
  }

  static Future<String?> getUserId() {
    return SharedPreferencesHandler.instance!.getString(SharedPrefConstants.USER_ID);
  }

  static Future<void> setEmail(String userName) async {
    await SharedPreferencesHandler.instance!.setString(SharedPrefConstants.EMAIL, userName);
  }

  static Future<String?> getEmail() {
    return SharedPreferencesHandler.instance!.getString(SharedPrefConstants.EMAIL);
  }

  static Future<void> removeUsername() async {
    await SharedPreferencesHandler.instance!.remove(SharedPrefConstants.EMAIL);
  }

  static Future<String?> getAuthDetails() async {
    String? authString = await SharedPreferencesHandler.instance!.getString(SharedPrefConstants.ACCESS_TOKEN);
    return authString;
  }

  Future<String?> accessToken() async {
    String? _accessToken = await getAuthDetails();
    return _accessToken;
  }

  static Future<bool> isLoggedIn() async {
    String? _isLoggedIn = await getAuthDetails();
    return (_isLoggedIn != null);
  }

  static Future<void> removeAuthDetails() async {
    await SharedPreferencesHandler.instance!.remove(SharedPrefConstants.ACCESS_TOKEN);
  }

  static Future<void> removeRefreshToken() async {
    await SharedPreferencesHandler.instance!.remove(SharedPrefConstants.REFRESH_TOKEN);
  }

  static Future<void> removeUserId() async {
    await SharedPreferencesHandler.instance!.remove(SharedPrefConstants.USER_ID);
  }

  static Future<bool?> isUserLoggedIn() {
    return SharedPreferencesHandler.instance!.getBool(SharedPrefConstants.IS_LOGGED_IN);
  }

}